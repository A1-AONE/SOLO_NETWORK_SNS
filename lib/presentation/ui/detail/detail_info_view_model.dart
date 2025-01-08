import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/usecase/create_comment_usecase.dart';

class DetailViewModel extends StateNotifier<CreateCommentstate>{
  final CreateCommentUsecase createCommentUsecase;
  DetailViewModel(this.createCommentUsecase) : super(CreateCommentstate());

  Future<void> postComment(String uid, String feedId) async{
    final commenctEntity = CommentEntity(
      comment: state.contentEditingController.text,
      createdAt: DateTime.now().toIso8601String(),
      feed_id: feedId,
      goods: '',
      user_id: uid,
    );
  await createCommentUsecase.execute(commenctEntity);
  }

    void clearFields() {
    state = CreateCommentstate(); // 기본 상태로 초기화
  }

}

class CreateCommentstate{
  final TextEditingController contentEditingController;

  CreateCommentstate({
    TextEditingController? contentEditingController,
  }) : contentEditingController = contentEditingController ?? TextEditingController();

}



final createViewModelProvider = StateNotifierProvider<DetailViewModel, CreateCommentstate>((ref) {
  final CreateCommentUsecase = ref.watch(createCommentUseCaseProvider);
  return DetailViewModel(CreateCommentUsecase);
});