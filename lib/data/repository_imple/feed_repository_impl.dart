import 'dart:io';

import 'package:solo_network_sns/data/source/feed_data_source.dart';
import 'package:solo_network_sns/domain/entitiy/feed.dart';
import 'package:solo_network_sns/domain/repository/feed_fetch_repository.dart';

class FeedRepositoryImpl implements FeedFetchRepository {
  FeedRepositoryImpl(
    this._feedDataSource,
  );

  final FeedDataSource _feedDataSource;

  @override
  Future<List<Feed>?> fetchFeeds() async {
    final result = await _feedDataSource.fetchFeeds();
    return result
        .map((e) => Feed(
              id: e.id,
              UID: e.UID,
              contents: e.contents,
              createdAt: e.createdAt,
              goods: e.goods,
              imageUrl: e.imageUrl,
              tag: e.tag,
              AI: e.AI,
            ))
        .toList();
  }
}
