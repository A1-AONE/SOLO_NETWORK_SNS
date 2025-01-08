import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed.dart';
import 'package:solo_network_sns/presentation/ui/feed/providers.dart';

class FeedPageViewModel extends Notifier<List<Feed>?>{
  @override
  List<Feed>? build() {
    fetchFeeds();
    throw [];
  }

  Future<void> fetchFeeds() async{
    state = await ref.read(fetchFeedsUsecaseProvider).fetchFeedsExecute();
  }
  
}

final feedsViewModel = NotifierProvider<FeedPageViewModel, List<Feed>?>(
  () => FeedPageViewModel()
);