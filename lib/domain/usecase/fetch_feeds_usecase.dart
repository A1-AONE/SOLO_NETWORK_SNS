import 'package:solo_network_sns/domain/entitiy/feed.dart';
import 'package:solo_network_sns/domain/repository/feed_repository.dart';

class FetchFeedsUsecase {
  FetchFeedsUsecase(this._feedRepository);
  final FeedRepository _feedRepository;

  Future<List<Feed>?> fetchFeedsExecute() async{
    return await _feedRepository.fetchFeeds();
  }
}