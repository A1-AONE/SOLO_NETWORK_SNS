const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

const {onSchedule} = require("firebase-functions/v2/scheduler");
const {logger} = require("firebase-functions");
const {GoogleGenerativeAI} = require("@google/generative-ai");

initializeApp(); // Firebase 앱을 초기화합니다.

const db = getFirestore();

const genAI = new GoogleGenerativeAI("AIzaSyDuk5NFH5e6XYpB8uj5vVt0jgA8qlekSCo");
const model = genAI.getGenerativeModel({model: "gemini-1.5-flash"});

// AI 피드가 작성되도록하는 스케줄함수
// 10분에 한번씩 호출
// 먼저 User의 데이터를 새로 갱신한다.
// 그후, User의 최신 피드가 60분전 이상일경우 AI의 피드가 작성되도록 한다.
// User가 선택한 AITag중 하나의 성격이 랜덤으로 설정되어 피드를 작성
// 만약 해당 User의 최신피드가 없는 경우에도 생성
exports.scheduledAiFeed = onSchedule("*/10 * * * *", async (event) => {
    const usersRef = db.collection("User");
    const userSnapshot = await usersRef.get();

    const usersMap = new Map();
    let allKeyArray = [];
    const aiTags = [];

    userSnapshot.forEach((doc) => {
        const userData = doc.data();
        const uid = doc.id;
        usersMap.set(uid, userData);
    });

    allKeyArray = Array.from(usersMap.keys());
    allKeyArray.forEach((uid) => {
        const aiArray = usersMap.get(uid).AITag;
        const randomAiTag = aiArray[Math.floor(Math.random() * aiArray.length)];
        aiTags.push(randomAiTag);
    });

    logger.log("Update All Keys:", allKeyArray);
    logger.log("Update All AiTag: ", aiTags);

    const feedRef = db.collection("Feed");

    const now = new Date();

    let index = 0;
    for (const uid of allKeyArray) {
        const feedSnapshot = await feedRef
            .where("UID", "==", uid)
            .orderBy("createdAt", "desc")
            .limit(1)
            .get();

        if (!feedSnapshot.empty) {
            const latestFeed = feedSnapshot.docs[0];
            const latestFeedCreatedAt = latestFeed.data().createdAt;

            const createdAtDate = new Date(latestFeedCreatedAt);
            const hoursAgo = new Date(now.getTime() - 60 * 60 * 1000);

            if (createdAtDate < hoursAgo) {
                const feedDoc = feedRef.doc();

                const prompt = `"""
                다음 조건들을 만족하는 SNS 글을 하나 만들어줘

                작성글은 반드시 아래의 조건을 만족해야해.
                1. 밑에서 제시하는 성격을 가진 사람이 작성한 글처럼 작성되어야 함.
                2. 이모티콘은 절대 사용하지 않음 (이모티콘을 사용하지 말고, 텍스트로만 작성해 주세요).
                3. 글에는 욕설이나, 비속어가 들어가 있으면 안됨.
                4. 관련 태그가 1 ~ 4개 정도 있어야 함.

                성격은 다음과 같아:
                # ${aiTags[index]}

                **답변은 오직 JSON 형식으로만 작성해 줘.**

                예시는 다음과 같아.
                {
                  content: "글 작성내용",
                  tags: ['기쁘다','재밌다']
                }
                """
                `;

                const result = await model.generateContent(prompt);
                logger.log(result.response.text());

                const cleanResponse = result.response.text().replace(/```json|```/g, "").trim();

                const parsedResponse = JSON.parse(cleanResponse);

                const content = parsedResponse.content;
                const tags = parsedResponse.tags;

                const aiFeed = {
                    AI: aiTags[index],
                    UID: uid,
                    contents: content,
                    createdAt: now.toISOString(),
                    goods: 0,
                    imageUrl: null,
                    tags: tags,
                };

                await feedDoc.create(aiFeed);
                logger.log(`${uid} feed add AiFeed`);
            } else {
                logger.log(`${uid} latestfeed is not over 60 minite`);
            }
        } else {
            logger.log(`No feed found for ${uid}`);

            if (aiTags[index] == null || aiTags[index] == "") {
              logger.log(`user : ${uid} is not setting`);
            } else {
              const feedDoc = feedRef.doc();

              const prompt = `"""
              다음 조건들을 만족하는 SNS 글을 하나 만들어줘
  
              작성글은 반드시 아래의 조건을 만족해야해.
              1. 밑에서 제시하는 성격을 가진 사람이 작성한 글처럼 작성되어야 함.
              2. 이모티콘은 절대 사용하지 않음 (이모티콘을 사용하지 말고, 텍스트로만 작성해 주세요).
              3. 글에는 욕설이나, 비속어가 들어가 있으면 안됨.
              4. 관련 태그가 1 ~ 4개 정도 있어야 함.
  
              성격은 다음과 같아:
              # ${aiTags[index]}
  
              **답변은 오직 JSON 형식으로만 작성해 줘.**
  
              예시는 다음과 같아.
              {
                content: "글 작성내용",
                tags: ['기쁘다','재밌다']
              }
              """
              `;

              const result = await model.generateContent(prompt);
              logger.log(result.response.text());

              const cleanResponse = result.response.text().replace(/```json|```/g, "").trim();

              const parsedResponse = JSON.parse(cleanResponse);

              const content = parsedResponse.content;
              const tags = parsedResponse.tags;

              const aiFeed = {
                  AI: aiTags[index],
                  UID: uid,
                  contents: content,
                  createdAt: now.toISOString(),
                  goods: 0,
                  imageUrl: null,
                  tags: tags,
              };

              await feedDoc.create(aiFeed);
              logger.log(`${uid} feed add AiFeed`);
            }
        }

        index += 1;
    }
});


// AI 댓글이 작성되도록하는 스케줄함수
// 5분당 한번씩 호출
// 먼저 User의 데이터를 새로 갱신한다.
// User의 최신 피드의 시간순 상위 10개 피드중 하나에 AI 댓글이 달림
// 댓글달 피드를 선택하는 방법은 상위 10개 피드중 랜덤
// User가 선택한 AITag중 하나의 성격이 랜덤으로 설정되어 댓글을 달게됨
exports.scheduledAiComments = onSchedule("*/5 * * * *", async (event) => {
    const usersRef = db.collection("User");
    const userSnapshot = await usersRef.get();

    const usersMap = new Map();
    let allKeyArray = [];
    const aiTags = [];

    userSnapshot.forEach((doc) => {
        const userData = doc.data();
        const uid = doc.id;
        usersMap.set(uid, userData);
    });

    allKeyArray = Array.from(usersMap.keys());
    allKeyArray.forEach((uid) => {
        const aiArray = usersMap.get(uid).AITag;
        const randomAiTag = aiArray[Math.floor(Math.random() * aiArray.length)];
        aiTags.push(randomAiTag);
    });

    logger.log("Update All Keys:", allKeyArray);
    logger.log("Update All AiTag: ", aiTags);

    const feedRef = db.collection("Feed");
    const now = new Date();

    let index = 0;
    for (const uid of allKeyArray) {
        const feedSnapshot = await feedRef
            .where("UID", "==", uid)
            .orderBy("createdAt", "desc")
            .limit(10)
            .get();

        if (!feedSnapshot.empty) {
            const selectedFeed = feedSnapshot.docs[Math.floor(Math.random() * feedSnapshot.docs.length)];
            const selectedFeedId = selectedFeed.id;
            const selectedFeedcontents = selectedFeed.data().contents;

            const commentRef = db.collection("Comment");

            const prompt = `"""
            다음 조건들을 만족하는 SNS 댓글을 하나 만들어줘

            댓글은 반드시 아래의 조건을 만족해야해.
            1. 밑에서 제시하는 성격을 가진 사람이 작성한 글처럼 작성되어야 함.
            2. 제시된 글에 대한 댓글이어야 함.
            3. 이모티콘은 절대 사용하지 않음 (이모티콘을 사용하지 말고, 텍스트로만 작성해 줘).
            4. 글에는 욕설이나, 비속어가 들어가 있으면 안됨.
            5. 댓글은 30자이내로 작성되어야 해

            성격은 다음과 같아:
            # ${aiTags[index]}

            제시글은 다음과 같아:
            ${selectedFeedcontents}

            **답변은 오직 JSON 형식으로만 작성해 줘.**

            예시는 다음과 같아.
            {
                comment: "댓글내용",
            }
            """
            `;

            const result = await model.generateContent(prompt);
            logger.log(result.response.text());

            const cleanResponse = result.response.text().replace(/```json|```/g, "").trim();

            const parsedResponse = JSON.parse(cleanResponse);
            const comment = parsedResponse.comment

            const aiComment = {
                "AI": aiTags[index],
                "comment": comment,
                "createdAt": now.toISOString(),
                "feed_id": selectedFeedId,
                "goods": "",
                "user_id": uid,
            };

            const commentDoc = commentRef.doc();

            await commentDoc.create(aiComment);
            logger.log(`uid: ${uid}, feed: ${selectedFeedId} add AiComments`);
        } else {
            logger.log(`uid: ${uid} 댓글달 피드가 없음`);
        }

        index += 1;
    }
});
