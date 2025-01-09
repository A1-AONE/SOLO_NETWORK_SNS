import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/user_entity.dart';
import 'package:solo_network_sns/presentation/widgets/nickname_bar/feed_nickname_bar_providers.dart';

class FeedNicknameBarViewModel extends Notifier<List<UserEntity>?> {
  @override
  List<UserEntity>? build() {
    return null;
  }

  Future<void> fetchUser() async {
    try {
      final fetchedUser =
          await ref.read(fetchUserUsecaseProvider).fetchUserExecute();
      state = fetchedUser;
    } catch (e) {
      state = [];
    }
  }
}

final userViewModel =
    NotifierProvider<FeedNicknameBarViewModel, List<UserEntity>?>(
  () => FeedNicknameBarViewModel(),
);
