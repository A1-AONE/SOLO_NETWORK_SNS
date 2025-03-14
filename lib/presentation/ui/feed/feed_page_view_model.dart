import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed.dart';
import 'package:solo_network_sns/presentation/ui/feed/providers.dart';

class FeedPageViewModel extends AutoDisposeNotifier<List<Feed>?> {
  bool isFirstToast = true;

  @override
  List<Feed>? build() {
    //fetchFeeds();
    streamFeeds();
    return [];
  }

  Future<void> fetchFeeds() async {
    try {
      final fetchedFeeds =
          await ref.read(fetchFeedsUsecaseProvider).fetchFeedsExecute();
      state = fetchedFeeds; // 데이터를 가져오면 상태 업데이트
    } catch (e) {
      // 에러 발생 시 null 또는 빈 리스트를 상태로 설정
      state = [];
    }
  }

  void streamFeeds() {
    log('feed stream start');
    final stream = ref.read(fetchFeedsUsecaseProvider).streamFeedsExecute();
    final streamSubscription = stream.listen((e) {
      state = e;
    });
    ref.onDispose(() {
      log('feed stream cancel');
      streamSubscription.cancel();
    });
  }
}

final feedsViewModel =
    AutoDisposeNotifierProvider<FeedPageViewModel, List<Feed>?>(
        () => FeedPageViewModel());
