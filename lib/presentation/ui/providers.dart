
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/data/repository_imple/feed_repository_impl.dart';
import 'package:solo_network_sns/data/source/feed_data_source.dart';
import 'package:solo_network_sns/data/source/feed_data_source_impl.dart';
import 'package:solo_network_sns/domain/repository/feed_fetch_repository.dart';
import 'package:solo_network_sns/domain/usecase/fetch_feeds_usecase.dart';

final feedsDataSourceProvider = Provider<FeedDataSource>((ref) {
  return FeedDataSourceImpl();
});

final feedRepositoryProvider = Provider<FeedFetchRepository>((ref) {
  final dataSource = ref.read(feedsDataSourceProvider);
  return FeedRepositoryImpl(dataSource);
});

final fetchFeedsUsecaseProvider = Provider((ref) {
  final FeedRepo = ref.read(feedRepositoryProvider);
  return FetchFeedsUsecase(FeedRepo);
});
