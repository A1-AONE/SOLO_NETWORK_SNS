import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entity.dart';
import 'package:solo_network_sns/domain/usecase/create_feed_use_case.dart';
import 'package:solo_network_sns/presentation/ui/create_page/viewmodel/yolo_detection.dart';
import 'package:image/image.dart' as img;
import 'package:solo_network_sns/presentation/ui/providers.dart';

class CreateViewModel extends StateNotifier<CreateState> {
  final CreateFeedUseCase createFeedUseCase;
  final YoloDetection yoloDetection;

  CreateViewModel(this.createFeedUseCase, this.yoloDetection)
      : super(CreateState());

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
  Future<bool> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // YOLO 분석을 위해 이미지 읽기
      final imageBytes = File(image.path).readAsBytesSync();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage != null) {
        // 사람이 감지되었는지 확인
        final isPersonDetected = await yoloDetection.detectPerson(decodedImage);
        if (isPersonDetected) {
          // 사람이 감지되면 true 반환
          state = state.copyWith(errorMessage: '사람이 포함된 사진은 업로드할 수 없습니다.');
          return true;
        }
      }

      // 사람이 감지되지 않으면 false 반환
      state = state.copyWith(selectedImage: image, errorMessage: null);
    }
    return false;
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
  final String? errorMessage;

  CreateState({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    this.tags = const [],
    this.selectedImage,
    this.errorMessage,
  })  : contentEditingController =
            contentEditingController ?? TextEditingController(),
        tagEditingController = tagEditingController ?? TextEditingController();

  CreateState copyWith({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    List<String>? tags,
    XFile? selectedImage,
    String? errorMessage,
  }) {
    return CreateState(
      contentEditingController:
          contentEditingController ?? this.contentEditingController,
      tagEditingController: tagEditingController ?? this.tagEditingController,
      tags: tags ?? this.tags,
      selectedImage: selectedImage ?? this.selectedImage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Provider 정의
final createViewModelProvider =
    StateNotifierProvider<CreateViewModel, CreateState>((ref) {
  final createFeedUseCase = ref.watch(createFeedUseCaseProvider);
  final yoloDetection = ref.watch(yoloDetectionProvider);
  return CreateViewModel(createFeedUseCase, yoloDetection); // 두 번째 인자 추가
});
