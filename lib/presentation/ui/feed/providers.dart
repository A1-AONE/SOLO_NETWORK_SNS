import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/data/repository_imple/feed_repository_impl.dart';
import 'package:solo_network_sns/data/source/feed_data_source.dart';
import 'package:solo_network_sns/data/source/feed_data_source_impl.dart';
import 'package:solo_network_sns/domain/repository/feed_fetch_repository.dart';
import 'package:solo_network_sns/domain/usecase/fetch_feeds_usecase.dart';
import 'package:solo_network_sns/presentation/ui/create_page/view_model/yolo_detection.dart';

final feedsDataSourceProvider = Provider<FeedDataSource>((ref) {
  return FeedDataSourceImpl();
});

final feedRepositoryProvider = Provider<FeedFetchRepository>((ref) {
  final dataSource = ref.read(feedsDataSourceProvider);
  return FeedRepositoryImpl(dataSource);
});

final fetchFeedsUsecaseProvider = Provider((ref) {
  final feedRepo = ref.read(feedRepositoryProvider);
  return FetchFeedsUsecase(feedRepo);
});

final yoloDetectionProvider = Provider<YoloDetection>((ref) {
  final yoloDetection = YoloDetection();
  // YOLO 모델 초기화
  yoloDetection.initialize().catchError((e) {
    throw Exception('Failed to initialize YOLO model: $e');
  });
  return yoloDetection;
});
