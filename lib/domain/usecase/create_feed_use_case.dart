import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entity.dart';
import 'package:solo_network_sns/domain/repository/feed_repository.dart';

class CreateFeedUseCase {
  final FeedRepository repository;

  CreateFeedUseCase(this.repository);

  Future<void> execute(FeedEntity feedEntity, File? imageFile) async {
    await repository.createPost(feedEntity, imageFile);
  }
}

final createFeedUseCaseProvider = Provider<CreateFeedUseCase>((ref) {
  final feedRepository = ref.watch(feedRepositoryProvider);
  return CreateFeedUseCase(feedRepository);
});
