import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateViewModel extends StateNotifier<CreateState> {
  CreateViewModel() : super(CreateState());

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
  return CreateViewModel();
});
