import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/data/repository_imple/user_profile_repository_impl.dart';
import 'package:solo_network_sns/domain/usecase/get_user_profile_data_usecase.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';
import 'package:solo_network_sns/presentation/viewmodel/user_id.dart';

// 상태 클래스 정의
class MyPageState {
  final String? profileUrl;
  final String? nickName;
  final File? profileImage;
  final List<String> aiTag; // 추가

  const MyPageState({
    this.profileUrl,
    this.nickName,
    this.profileImage,
    this.aiTag = const [], // 초기 값 설정
  });

  MyPageState copyWith({
    String? profileUrl,
    String? nickName,
    File? profileImage,
    List<String>? aiTag,
  }) {
    return MyPageState(
      profileUrl: profileUrl ?? this.profileUrl,
      nickName: nickName ?? this.nickName,
      profileImage: profileImage ?? this.profileImage,
      aiTag: aiTag ?? this.aiTag,
    );
  }
}

class MyPageViewModel extends StateNotifier<MyPageState> {
  final ImagePicker _picker = ImagePicker();
  final GetUserProfileDataUseCase _getUserProfileDataUseCase;

  MyPageViewModel(this._getUserProfileDataUseCase)
      : super(MyPageState(
          profileUrl: '', // 초기 프로필 URL
          nickName: '홍길동', // 초기 닉네임
          aiTag: [], // 초기값
        ));

  // 갤러리에서 이미지 선택
  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = state.copyWith(profileImage: File(pickedFile.path));
    }
  }

  // 사용자 데이터 초기화
  Future<void> initializeUserData(String uid) async {
    try {
      final user =
          await _getUserProfileDataUseCase.call(uid); // GetUserDataUseCase 호출
      state = state.copyWith(
        profileUrl: user.profileUrl,
        nickName: user.nickName,
        aiTag: user.aiTag, // aiTag
      );
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> removeTag(String tag) async {
    // 태그가 1개만 남았을 경우 삭제 방지
    if (state.aiTag.length > 1) {
      // 태그 삭제 로직 (서버 통신 없이 화면에서만 삭제)
      final updatedTags = List<String>.from(state.aiTag)..remove(tag);
      state = state.copyWith(aiTag: updatedTags);
    }
  }
}

// GetUserDataUseCase 프로바이더 정의
final getUserDataUseCaseProvider = Provider<GetUserProfileDataUseCase>((ref) {
  final userProfileRepository =
      ref.watch(userProfileRepositoryProvider); // UserRepository 의존성
  return GetUserProfileDataUseCase(userProfileRepository);
});

// MyPageViewModel 프로바이더 정의 (StateNotifierProvider로 변경)
final myPageViewModelProvider =
    StateNotifierProvider<MyPageViewModel, MyPageState>((ref) {
  final getUserDataUseCase = ref.watch(getUserDataUseCaseProvider); // 의존성 주입
  return MyPageViewModel(getUserDataUseCase);
});

// UserRepository 프로바이더 정의
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl(); // 실제 UserRepository 구현체를 반환
});
