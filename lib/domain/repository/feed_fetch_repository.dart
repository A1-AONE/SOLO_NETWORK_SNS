
import 'package:solo_network_sns/domain/entitiy/feed.dart';

abstract interface class FeedFetchRepository {
  Future<List<Feed>?> fetchFeeds();
}
