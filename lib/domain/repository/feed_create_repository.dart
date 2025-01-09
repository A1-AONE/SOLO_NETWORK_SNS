import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed_create_entity.dart';
import 'package:solo_network_sns/data/repository_imple/feed_create_repository_impl.dart';

abstract interface class FeedCreateRepository {
  Future<void> createPost(FeedCreateEntity feedEntity, File? imageFile);
}

final feedCreateRepositoryProvider = Provider<FeedCreateRepository>((ref) {
  return FeedCreateRepositoryImpl(
      FirebaseFirestore.instance, FirebaseStorage.instance);
});
