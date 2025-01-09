import 'package:solo_network_sns/domain/entitiy/feed.dart';
import 'package:solo_network_sns/domain/repository/feed/feed_fetch_repository.dart';

class FetchFeedsUsecase {
  FetchFeedsUsecase(this._feedRepository);
  final FeedFetchRepository _feedRepository;

  Future<List<Feed>?> fetchFeedsExecute() async{
    return await _feedRepository.fetchFeeds();
  }

    Stream<List<Feed>?> streamFeedsExecute() {
    return _feedRepository.streamFeeds();
  }
}