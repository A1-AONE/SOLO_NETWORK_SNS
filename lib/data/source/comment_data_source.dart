import 'package:solo_network_sns/data/dto/comment_dto.dart';

abstract interface class CommentDataSource {
  Future<List<CommentDto>> fetchComments();
  }