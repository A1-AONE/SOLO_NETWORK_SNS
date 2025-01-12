import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solo_network_sns/data/repository_imple/login_repository_impl.dart';
import 'package:solo_network_sns/data/source/login_data_source.dart';
import 'package:solo_network_sns/data/source/login_data_source_impl.dart';
import 'package:solo_network_sns/domain/repository/login_repository.dart';
import 'package:solo_network_sns/domain/usecase/login_use_case.dart';
import 'package:solo_network_sns/presentation/ui/login/login_view_model.dart';

// 의존성 주입!


final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  final googleSignIn = ref.read(googleSignInProvider);
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return LoginDataSourceImpl(
    googleSignIn: googleSignIn,
    auth: auth,
    firestore: firestore,
  );
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dataSource = ref.read(loginDataSourceProvider);
  return LoginRepositoryImpl(dataSource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginUseCase(repository);
});

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, String>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginViewModel(loginUseCase);
});
