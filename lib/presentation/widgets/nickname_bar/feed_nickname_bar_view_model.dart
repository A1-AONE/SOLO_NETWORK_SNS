import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/user_entity.dart';
import 'package:solo_network_sns/presentation/widgets/nickname_bar/feed_nickname_bar_providers.dart';

class FeedNicknameBarViewModel extends Notifier<List<UserEntity>?> {
  @override
  List<UserEntity>? build() {
    //fetchUser();
    streamNames();
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

  void streamNames() {
    log('Name stream start');
    final stream = ref.read(fetchUserUsecaseProvider).streamUserExecute();
    final streamSubscription = stream.listen((e) {
      state = e;
    });
    ref.onDispose(() {
      log('Name stream cancel');
      streamSubscription.cancel();
    });
  }
}

final userViewModel =
    NotifierProvider<FeedNicknameBarViewModel, List<UserEntity>?>(
  () => FeedNicknameBarViewModel(),
);
