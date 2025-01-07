

import 'package:solo_network_sns/domain/entitiy/feed.dart';

abstract interface class FeedRepository {
  Future<List<Feed>?> fetchFeeds();
}