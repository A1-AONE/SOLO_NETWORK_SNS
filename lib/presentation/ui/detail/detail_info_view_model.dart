import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/usecase/create_comment_usecase.dart';

class DetailViewModel extends StateNotifier<CreateCommentstate> {
  final CreateCommentUsecase createCommentUsecase;
  DetailViewModel(this.createCommentUsecase) : super(CreateCommentstate());

  Future<void> postComment(String uid, String feedId) async {
    state.isUpload = true;

    final commenctEntity = CommentEntity(
      ai: '',
      comment: state.contentEditingController.text,
      createdAt: DateTime.now().toIso8601String(),
      feed_id: feedId,
      goods: '',
      user_id: uid,
    );
    await createCommentUsecase.execute(commenctEntity);

    state.isUpload = false;
  }

  void clearFields() {
    state = CreateCommentstate(); // 기본 상태로 초기화
  }

  bool isUpload(){
    return state.isUpload;
  }
}

class CreateCommentstate {
  final TextEditingController contentEditingController;
  bool isUpload;

  CreateCommentstate({
    TextEditingController? contentEditingController,
    bool? isUpload,
  })  : contentEditingController =
            contentEditingController ?? TextEditingController(),
        isUpload = false;
}

final createViewModelProvider =
    StateNotifierProvider<DetailViewModel, CreateCommentstate>((ref) {
  final CreateCommentUsecase = ref.watch(createCommentUseCaseProvider);
  return DetailViewModel(CreateCommentUsecase);
});
