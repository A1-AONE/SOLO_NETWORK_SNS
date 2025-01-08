
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_repository.dart';

class CreateCommentUsecase {
  final CommentRepository repository;

  CreateCommentUsecase(this.repository);

  Future<void> execute(CommentEntity commentEntity) async {
    await repository.createComment(commentEntity);
  }
}

final createCommentUseCaseProvider = Provider<CreateCommentUsecase>((ref) {
  final createCommentRepository = ref.watch(commentRepositoryProvider);
  return CreateCommentUsecase(createCommentRepository);
});
