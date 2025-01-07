// 일단 유저의 uid를 확인하고, 해당 uid의 피드의 최신 피드가 언제 생성되었는지 확인
// 만약 가장 최근피드가 생성시간이 1~2시간 랜덤으로 맞춰진 시간보다 넘었을 경우 피드 생성
// 피드를 생성할때, uid의 AiTag 안의 임의의 태그를 하나 잡고,
// ai한테 피드 글 작성하나 해달라고 한다음 text 받아와서 피드 작성하기

const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onDocumentWritten} = require("firebase-functions/v2/firestore");

initializeApp(); // Firebase 앱을 초기화합니다.

const db = getFirestore();

exports.myfunction = onDocumentWritten({
  document: "User/{uid}",
  region: "asia-northeast3",
  }, async (event) => {
  // Firestore에서 데이터 가져오기
  const usersRef = db.collection("User");
  const userSnapshot = await usersRef.get();

  const usersMap = new Map();
  let allKeyArray = [];

  userSnapshot.forEach((doc) => {
    const userData = doc.data();
    const uid = doc.id;
    usersMap.set(uid, userData);
  });

  allKeyArray = Array.from(usersMap.keys());

  console.log("Users Map:", usersMap);
  console.log("All Keys:", allKeyArray);
});

/*
exports.myfunction = onDocumentWritten({
  document: "User/{uid}",
  region: "asia-northeast3",
  }, async (event) => {
  // Firestore에서 데이터 가져오기
  const usersRef = db.collection("test");
  const userSnapshot = usersRef.doc();

  userSnapshot.set({id: "1234"});
});
*/
