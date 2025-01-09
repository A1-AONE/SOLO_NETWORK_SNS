import 'package:solo_network_sns/data/dto/feed_dto.dart';

abstract interface class FeedDataSource {
  Future<List<FeedDto>> fetchFeeds();
  Stream<List<FeedDto>> streamFeeds();
  }