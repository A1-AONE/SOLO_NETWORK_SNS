import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entity.dart';
import 'package:solo_network_sns/domain/usecase/create_feed_use_case.dart';
import 'package:image/image.dart' as img;
import 'package:solo_network_sns/presentation/ui/create_page/viewmodel/yolo_detection.dart';

class CreateViewModel extends StateNotifier<CreateState> {
  final CreateFeedUseCase createFeedUseCase;

  CreateViewModel(this.createFeedUseCase) : super(CreateState());

  final ImagePicker _picker = ImagePicker();

  ///태그 입력
  void addTag() {
    String tag = state.tagEditingController.text.trim();
    if (tag.isNotEmpty) {
      state = state.copyWith(
        tags: [...state.tags, tag],
        tagEditingController: TextEditingController(), // 태그 추가 후 입력 필드 비우기
      );
    }
  }

  ///태그 삭제
  void removeTag(String tag) {
    state = state.copyWith(
      tags: state.tags.where((t) => t != tag).toList(),
    );
  }

  ///이미지피커
  Future<void> pickImage(BuildContext context) async {
    final yoloDetection = YoloDetection();
    // YOLO 모델 초기화 확인 및 초기화 실행
    if (!yoloDetection.isInitialized) {
      await yoloDetection.initialize(); // 모델 초기화
    }
    img.Image? image; // image 패키지의 Image 객체

    // 이미지 선택 중 로딩 화면 표시
    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 바깥을 눌러도 닫히지 않도록 설정
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(), // 로딩 표시
        );
      },
    );

    try {
      final XFile? newImageFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (newImageFile != null) {
        state = state.copyWith(selectedImage: newImageFile);

        // newImageFile을 image로 변환
        final file = File(newImageFile.path);
        final imageBytes = await file.readAsBytes();
        final decodedImage = img.decodeImage(imageBytes);

        if (decodedImage != null) {
          image = decodedImage; // 변환된 이미지 객체
        } else {
          throw Exception('Failed to decode the selected image');
        }
      } else {
        throw Exception('No image selected');
      }

      // 변환된 image 객체로 YOLO 모델 실행
      if (image != null) {
        state = state.copyWith(notPerson: yoloDetection.runInference(image));
      } else {
        throw Exception('Image conversion failed');
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      // 이미지 처리 완료 후 다이얼로그 닫기
      Navigator.of(context).pop(); // 다이얼로그 닫기
    }
  }

  Future<void> postFeed(String uid) async {
    final feedEntity = FeedEntity(
      UID: uid,
      contents: state.contentEditingController.text,
      tags: state.tags,
      imagUrl: null, // Firestore에서 처리됨
      createdAt: DateTime.now().toIso8601String(),
      goods: 0,
    );
    await createFeedUseCase.execute(
        feedEntity,
        state.selectedImage?.path != null
            ? File(state.selectedImage!.path)
            : null);
  }

  // 상태 초기화 메서드 추가
  void clearFields() {
    state = CreateState(); // 기본 상태로 초기화
  }
}

class CreateState {
  final TextEditingController contentEditingController;
  final TextEditingController tagEditingController;
  final List<String> tags;
  final XFile? selectedImage;
  final bool notPerson;

  CreateState({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    this.tags = const [],
    this.selectedImage,
    this.notPerson = true,
  })  : contentEditingController =
            contentEditingController ?? TextEditingController(),
        tagEditingController = tagEditingController ?? TextEditingController();

  CreateState copyWith({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    List<String>? tags,
    XFile? selectedImage,
    bool? notPerson,
  }) {
    return CreateState(
      contentEditingController:
          contentEditingController ?? this.contentEditingController,
      tagEditingController: tagEditingController ?? this.tagEditingController,
      tags: tags ?? this.tags,
      selectedImage: selectedImage ?? this.selectedImage,
      notPerson: notPerson ?? this.notPerson,
    );
  }
}

// Provider 정의
final createViewModelProvider =
    StateNotifierProvider<CreateViewModel, CreateState>((ref) {
  final createFeedUseCase = ref.watch(createFeedUseCaseProvider);
  return CreateViewModel(createFeedUseCase);
});
