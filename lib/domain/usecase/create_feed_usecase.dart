import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed_create_entity.dart';
import 'package:solo_network_sns/domain/repository/feed_create_repository.dart';

class CreateFeedUseCase {
  final FeedCreateRepository repository;

  CreateFeedUseCase(this.repository);

  Future<void> execute(FeedCreateEntity feedEntity, File? imageFile) async {
    await repository.createPost(feedEntity, imageFile);
  }
}

final createFeedUseCaseProvider = Provider<CreateFeedUseCase>((ref) {
  final feedRepository = ref.watch(feedCreateRepositoryProvider);
  return CreateFeedUseCase(feedRepository);
});
