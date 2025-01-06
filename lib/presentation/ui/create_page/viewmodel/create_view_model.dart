import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entiry.dart';
import 'package:solo_network_sns/domain/usecase/create_feed_use_case.dart';

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
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(selectedImage: image);
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
    print("${feedEntity.UID}aaaaaaaaaaaa");
    print("${feedEntity.contents}aaaaaaaaaaaa");
    print("${feedEntity.createdAt}aaaaaaaaaaaa");
    print("${feedEntity.tags}aaaaaaaaaaaa");
    await createFeedUseCase.execute(
        feedEntity,
        state.selectedImage?.path != null
            ? File(state.selectedImage!.path)
            : null);
  }
}

class CreateState {
  final TextEditingController contentEditingController;
  final TextEditingController tagEditingController;
  final List<String> tags;
  final XFile? selectedImage;

  CreateState({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    this.tags = const [],
    this.selectedImage,
  })  : contentEditingController =
            contentEditingController ?? TextEditingController(),
        tagEditingController = tagEditingController ?? TextEditingController();

  CreateState copyWith({
    TextEditingController? contentEditingController,
    TextEditingController? tagEditingController,
    List<String>? tags,
    XFile? selectedImage,
  }) {
    return CreateState(
      contentEditingController:
          contentEditingController ?? this.contentEditingController,
      tagEditingController: tagEditingController ?? this.tagEditingController,
      tags: tags ?? this.tags,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

// Provider 정의
final createViewModelProvider =
    StateNotifierProvider<CreateViewModel, CreateState>((ref) {
  final createFeedUseCase = ref.watch(createFeedUseCaseProvider);
  return CreateViewModel(createFeedUseCase);
});
