import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';

abstract interface class CommentFetchRepository {
  Future<List<CommentEntity>?> fetchComments();
  Stream<List<CommentEntity>?> streamComments();
}
