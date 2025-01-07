import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:solo_network_sns/domain/entitiy/feed_entiry.dart';
import 'package:solo_network_sns/domain/repository/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FeedRepositoryImpl(this.firestore, this.storage);

  @override
  Future<void> createPost(FeedEntity feedEntity, File? imageFile) async {
    String? imageUrl;

    // 1. 이미지 업로드
    if (imageFile != null) {
      final ref = storage.ref().child(
          'feeds/${feedEntity.UID}${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await ref.putFile(imageFile);
      imageUrl = await uploadTask.ref.getDownloadURL();
    }

    // 2. Firestore에 데이터 저장
    await firestore.collection('Feed').doc().set({
      'UID': feedEntity.UID,
      'contents': feedEntity.contents,
      'tags': feedEntity.tags,
      'imageUrl': imageUrl,
      'createdAt': feedEntity.createdAt,
      'goods': feedEntity.goods ?? 0,
    });
  }
}
