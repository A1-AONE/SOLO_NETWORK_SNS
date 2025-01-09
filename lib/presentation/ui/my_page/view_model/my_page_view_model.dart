import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/data/repository_imple/user_repository_impl.dart';
import 'package:solo_network_sns/domain/usecase/get_user_data_usecase.dart';
import 'package:solo_network_sns/domain/repository/user_repository.dart';
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
      final user = await _getUserDataUseCase.call(uid); // GetUserDataUseCase 호출
      state = state.copyWith(
        profileUrl: user.profileUrl,
        nickName: user.nickName,
        aiTag: user.aiTag, // aiTag
      );
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void removeTag(String tag) {
    final updatedTags = List<String>.from(state.aiTag)..remove(tag);
    state = state.copyWith(aiTag: updatedTags);
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
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(); // 실제 UserRepository 구현체를 반환
});
