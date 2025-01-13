import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/data/repository_imple/user_profile_repository_impl.dart';
import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';
import 'package:solo_network_sns/domain/usecase/get_user_data_usecase.dart';
import 'package:solo_network_sns/domain/usecase/save_user_data_usecase.dart';

// 상태 클래스 정의
class MyPageState {
  final String? profileUrl;
  final String? nickName;
  final File? profileImage;
  final List<String>? aiTag;
  final String? email;
  final bool? isCanSpying;
  bool isReset;
  bool isChange;

  MyPageState({
    required this.profileUrl,
    required this.nickName,
    required this.profileImage,
    required this.aiTag,
    required this.email,
    required this.isCanSpying,
    required this.isReset,
    required this.isChange,
  });

  MyPageState copyWith({
    String? profileUrl,
    String? nickName,
    File? profileImage,
    List<String>? aiTag,
    String? email,
    bool? isCanSpying,
    bool? isReset,
    bool? isChange,
  }) {
    return MyPageState(
      profileUrl: profileUrl ?? this.profileUrl,
      nickName: nickName ?? this.nickName,
      profileImage: profileImage ?? this.profileImage,
      aiTag: aiTag ?? this.aiTag,
      email: email ?? this.email,
      isCanSpying: isCanSpying ?? this.isCanSpying,
      isReset: isReset ?? this.isReset,
      isChange: isChange ?? this.isChange
    );
  }
}

class MyPageViewModel extends StateNotifier<MyPageState> {
  final ImagePicker _picker = ImagePicker();
  final GetUserDataUseCase _getUserDataUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  List<String> aiAllTags = [
    '상냥함',
    '유머러스',
    '논리적',
    '감성적',
    '직설적',
    '긍정적',
    '열정적',
    '공감적',
    '조용함',
    '낭만적',
    '전문적',
    '귀여움',
    '차가움',
    '논쟁적',
  ];

  MyPageViewModel(this._getUserDataUseCase, this._saveUserDataUseCase)
      : super(MyPageState(
          profileUrl: null,
          nickName: '',
          profileImage: null,
          aiTag: [],
          email: null,
          isCanSpying: false,
          isReset: false,
          isChange: false,
        ));

  // 갤러리에서 이미지 선택
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(profileImage: File(pickedFile.path), isChange: true);
    }
  }

  // 사용자 데이터 초기화
  Future<void> initializeUserData(String uid) async {
    try {
      final user = await _getUserDataUseCase.call(uid); // Firebase에서 데이터 호출
      state = MyPageState(
        profileUrl: user.profileUrl,
        nickName: user.nickName,
        aiTag: user.aiTag,
        profileImage: null,
        email: user.email,
        isCanSpying: user.isCanSpying,
        isReset: false,
        isChange: false,
      );
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // 태그 삭제
  void removeTag(String tag) {
    // 태그가 1개만 남았을 경우 삭제 방지
    if (state.aiTag!.length > 1) {
      // 태그 삭제 로직 (서버 통신 없이 화면에서만 삭제)
      final updatedTags = List<String>.from(state.aiTag!)..remove(tag);
      state = state.copyWith(aiTag: updatedTags, isChange: true);
    }
  }

  // 데이터 취소 (초기 상태로 리셋)
  Future<void> cancelUserData(String uid) async {
    state.isReset = true;
    try {
      await initializeUserData(uid);

      // 상태 변경 후, 상태를 출력하여 확인
      print('Updated profileImage: ${state.profileImage}');
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      state.isReset = false;
      state.isChange = false;
    }
  }

  // 사용자 데이터 저장 state.profileUrl,
  Future<void> saveUserDataViewModel(String uid) async {
    try {
      final updatedUserData = UserProfileEntity(
        aiTag: state.aiTag,
        nickName: state.nickName,
        profileUrl: state
            .profileUrl, // 로컬이미지 저장 필요시 user_profile_repository_impl파일에서 경로 수정됨
        uid: uid,
        email: state.email,
        isCanSpying: state.isCanSpying,
      );
      // UseCase 호출
      await _saveUserDataUseCase.call(updatedUserData,
          imageFile: state.profileImage);

      // UI에 반영
      print('User data saved successfully');
    } catch (e) {
      print("Error saving user data: $e");
    }
  }
}

// GetUserDataUseCase 프로바이더 정의
final getUserDataUseCaseProvider = Provider<GetUserDataUseCase>((ref) {
  final userRepository =
      ref.watch(userRepositoryProvider); // UserRepository 의존성
  return GetUserDataUseCase(userRepository);
});

// MyPageViewModel 프로바이더 정의
final myPageViewModelProvider =
    StateNotifierProvider<MyPageViewModel, MyPageState>((ref) {
  final getUserDataUseCase = ref.watch(getUserDataUseCaseProvider);
  final saveUserDataUseCase =
      ref.watch(saveUserDataUseCaseProvider); // SaveUserDataUseCase 추가
  return MyPageViewModel(getUserDataUseCase, saveUserDataUseCase);
});

// UserRepository 프로바이더 정의
final userRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl(); // 실제 UserRepository 구현체를 반환
});

final saveUserDataUseCaseProvider = Provider<SaveUserDataUseCase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return SaveUserDataUseCase(userRepository);
});
