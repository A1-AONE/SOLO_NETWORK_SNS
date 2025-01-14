import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solo_network_sns/data/source/login_data_source.dart';

// LoginDataSource에서 정의된 메서드 실제로 impl 하는 부분
// google sign in 이랑 firebase 연동
// firestore에 사용자 정보 저장

class LoginDataSourceImpl implements LoginDataSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  LoginDataSourceImpl({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _googleSignIn = googleSignIn,
        _auth = auth,
        _firestore = firestore;

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      return googleSignInAccount;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserCredential> signInWithFirebase(OAuthCredential credential) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QuerySnapshot<Object?>> fetchUserEmail(String email) async {
    try {
      final snapshot = await _firestore
          .collection('User')
          .where('email', isEqualTo: email)
          .get();
      return snapshot;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveNewUser(String uid, String email) async {
    try {
      final userDoc = _firestore.collection('User').doc(uid);
      await userDoc.set({
        'AITag': [],
        'Nickname': '',
        'isCanSpying': false,
        'profileUrl': '',
        'uid': uid,
        'email': email,
      });

      log('새로운 사용자 Firestore Database에 저장완료: $uid, $email');
    } catch (e) {
      log('저장실패errrrrrror: $e');
      rethrow;
    }
  }
}
