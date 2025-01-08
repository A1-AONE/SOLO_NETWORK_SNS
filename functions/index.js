// 일단 유저의 uid를 확인하고, 해당 uid의 피드의 최신 피드가 언제 생성되었는지 확인
// 만약 가장 최근피드가 생성시간이 1~2시간 랜덤으로 맞춰진 시간보다 넘었을 경우 피드 생성
// 피드를 생성할때, uid의 AiTag 안의 임의의 태그를 하나 잡고,
// ai한테 피드 글 작성하나 해달라고 한다음 text 받아와서 피드 작성하기

const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");

const {onSchedule} = require("firebase-functions/v2/scheduler");
const {logger} = require("firebase-functions");
// const {onDocumentWritten} = require("firebase-functions/v2/firestore");

// const PromisePool = require("es6-promise-pool").default;
// const MAX_CONCURRENT = 3;

initializeApp(); // Firebase 앱을 초기화합니다.

const db = getFirestore();

const usersMap = new Map();
let allKeyArray = [];

// 초기화 로직
async function initializeData() {
  const usersRef = db.collection("User");
  const userSnapshot = await usersRef.get();

  usersMap.clear();
  allKeyArray = [];

  userSnapshot.forEach((doc) => {
    const userData = doc.data();
    const uid = doc.id;
    usersMap.set(uid, userData);
  });

  allKeyArray = Array.from(usersMap.keys());

  logger.log("Initialization complete.");
  logger.log("Users Map:", usersMap);
  logger.log("All Keys:", allKeyArray);
}

// 배포 직후 실행
(async () => {
  logger.log("Running initialization after deployment...");
  await initializeData();
})();

/*
// User 문서의 수정,생성,삭제시 호출되는 함수
// User 데이터를 새로 갱신
exports.userUpdate = onDocumentWritten({
  document: "User/{uid}",
  region: "asia-northeast3",
  }, async (event) => {
  // Firestore에서 데이터 가져오기
  const usersRef = db.collection("User");
  const userSnapshot = await usersRef.get();

  usersMap.clear();
  allKeyArray = [];

  userSnapshot.forEach((doc) => {
    const userData = doc.data();
    const uid = doc.id;
    usersMap.set(uid, userData);
  });

  allKeyArray = Array.from(usersMap.keys());

  logger.log("Update All Keys:", allKeyArray);
});
*/

// AI 피드가 작성되도록하는 스케줄함수
// 10분에 한번씩 호출
// 먼저 User의 데이터를 새로 갱신한다.
// 그후, User의 최신 피드가 10분전 이상일경우 AI의 피드가 작성되도록 한다.
// 만약 해당 User의 최신피드가 없는 경우에도 생성
exports.scheduledAiFeed = onSchedule("*/1 * * * *", async (event) => {
  const usersRef = db.collection("User");
  const userSnapshot = await usersRef.get();

  usersMap.clear();
  allKeyArray = [];

  userSnapshot.forEach((doc) => {
    const userData = doc.data();
    const uid = doc.id;
    usersMap.set(uid, userData);
  });

  allKeyArray = Array.from(usersMap.keys());

  logger.log("Update All Keys:", allKeyArray);

  const feedRef = db.collection("Feed");

  for (const uid of allKeyArray) {
    const feedSnapshot = await feedRef.where("UID", "==", uid).orderBy("createdAt", "desc").limit(1).get();

    if (!feedSnapshot.empty) {
      const latestFeed = feedSnapshot.docs[0];
      const latestFeedCreatedAt = latestFeed.data().createdAt;

      const createdAtDate = new Date(latestFeedCreatedAt);

      const now = new Date();
      const tenMinutesAgo = new Date(now.getTime() - 10 * 60 * 1000);

      if (createdAtDate < tenMinutesAgo) {
        const feedDoc = feedRef.doc();

        const aiFeed = {
          UID: uid,
          contents: "스케줄러 테스트입니다~",
          createdAt: now.toISOString(),
          goods: 0,
          imageUrl: null,
          tags: [],
        };

        await feedDoc.create(aiFeed);
        logger.log(`${uid} feed add AiFeed`);
      } else {
        logger.log(`${uid} latestfeed is not over 10 minite`);
      }
    } else {
      logger.log(`No feed found for ${uid}`);
      const feedDoc = feedRef.doc();

      const aiFeed = {
        UID: uid,
        contents: "스케줄러 테스트입니다~",
        createdAt: now.toISOString(),
        goods: 0,
        imageUrl: null,
        tags: [],
      };

      await feedDoc.create(aiFeed);
      logger.log(`${uid} feed add AiFeed`);
    }
  }
});