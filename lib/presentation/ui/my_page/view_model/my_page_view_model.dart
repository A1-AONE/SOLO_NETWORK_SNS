import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/data/repository_imple/user_profile_repository_impl.dart';
import 'package:solo_network_sns/domain/usecase/get_user_data_usecase.dart';
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
  final GetUserDataUseCase _getUserDataUseCase;

  MyPageViewModel(this._getUserDataUseCase)
      : super(MyPageState(
          profileUrl: '', // 초기 프로필 URL
          nickName: '', // 초기 닉네임
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
    // 이미 데이터가 비어 있지 않은 경우에만 초기화 진행
    if (state.nickName != '') {
      return; // 이미 초기화된 경우 스킵
    }

    try {
      final user = await _getUserDataUseCase.call(uid); // Firebase에서 데이터 호출
      state = state.copyWith(
        profileUrl: user.profileUrl,
        nickName: user.nickName,
        aiTag: user.aiTag,
      );
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // 태그 삭제
  void removeTag(String tag) {
    final updatedTags = List<String>.from(state.aiTag)..remove(tag);
    state = state.copyWith(aiTag: updatedTags);
  }

  // 데이터 취소 (초기 상태로 리셋)
  Future<void> cancelUserData(String uid) async {
    try {
      // 이미 fetch가 완료된 상태에서 프로필 이미지를 null로 설정
      state = state.copyWith(profileImage: null);

      // 상태 변경 후, 상태를 출력하여 확인
      print('Updated profileImage: ${state.profileImage}');
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}

// GetUserDataUseCase 프로바이더 정의
final getUserDataUseCaseProvider = Provider<GetUserDataUseCase>((ref) {
  final userRepository =
      ref.watch(userRepositoryProvider); // UserRepository 의존성
  return GetUserDataUseCase(userRepository);
});

// MyPageViewModel 프로바이더 정의 (StateNotifierProvider로 변경)
final myPageViewModelProvider =
    StateNotifierProvider<MyPageViewModel, MyPageState>((ref) {
  final getUserDataUseCase = ref.watch(getUserDataUseCaseProvider); // 의존성 주입
  return MyPageViewModel(getUserDataUseCase);
});

// UserRepository 프로바이더 정의
final userRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepositoryImpl(); // 실제 UserRepository 구현체를 반환
});
