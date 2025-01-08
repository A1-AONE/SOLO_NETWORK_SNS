import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/data/repository_imple/comment_repository_impl.dart';
import 'package:solo_network_sns/data/source/comment_data_source.dart';
import 'package:solo_network_sns/data/source/comment_data_source_impl.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_fetch_repository.dart';
import 'package:solo_network_sns/domain/usecase/fetch_comment_usecase.dart';

final commentsDataSourceProvider = Provider<CommentDataSource>((ref) {
  return CommentDataSourceImpl();
});

final commentRepositoryProvider = Provider<CommentFetchRepository>((ref) {
  final datasource = ref.read(commentsDataSourceProvider);
  return CommentRepositoryImpl(datasource);
});

final fetchCommentUsecaseProvider = Provider((ref) {
  final commentRepo = ref.read(commentRepositoryProvider);
  return FetchCommentUsecase(commentRepo);
});

