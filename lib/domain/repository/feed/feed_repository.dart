
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entity.dart';
import 'package:solo_network_sns/domain/repository/feed/feed_repository_impl.dart';

abstract interface class FeedRepository {
  Future<void> createPost(FeedEntity feedEntity, File? imageFile);

}

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl(
      FirebaseFirestore.instance, FirebaseStorage.instance);
});
