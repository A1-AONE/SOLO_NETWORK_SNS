import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solo_network_sns/data/source/login_data_source.dart';
import 'package:solo_network_sns/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginDataSource);

  final LoginDataSource _loginDataSource;

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    return _loginDataSource.signInWithGoogle();
  }

  @override
  Future<UserCredential> signInWithFirebase(OAuthCredential credential) {
    return _loginDataSource.signInWithFirebase(credential);
  }

  @override
  Future<QuerySnapshot<Object?>> fetchUserEmail(String email) {
    return _loginDataSource.fetchUserEmail(email);
  }

  @override
  Future<void> saveNewUser(String uid, String email) {
    return _loginDataSource.saveNewUser(uid, email);
  }
}
