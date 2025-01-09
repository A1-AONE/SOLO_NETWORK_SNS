import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_fetch_repository.dart';

class FetchCommentUsecase {
  FetchCommentUsecase(this._commentFetchRepository);
  final CommentFetchRepository _commentFetchRepository;

  Future<List<CommentEntity>?> fetchCommentsExecute() async{
    return await _commentFetchRepository.fetchComments();
  }

  Stream<List<CommentEntity>?> streamCommentsExecute() {
    return _commentFetchRepository.streamComments();
  }
}
