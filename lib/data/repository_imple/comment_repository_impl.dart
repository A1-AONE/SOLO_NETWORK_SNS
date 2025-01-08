import 'package:solo_network_sns/data/source/comment_data_source.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_fetch_repository.dart';

class CommentRepositoryImpl implements CommentFetchRepository{
  CommentRepositoryImpl(
    this._commentDataSource
  );
  final CommentDataSource _commentDataSource;

  @override
  Future<List<CommentEntity>?> fetchComments() async{
    final result = await _commentDataSource.fetchComments();
    return result
        .map((e) => CommentEntity(
            comment: e.comment,
            createdAt: e.createdAt,
            feed_id: e.feed_id,
            goods: e.goods,
            user_id: e.user_id))
        .toList();
  }

}
