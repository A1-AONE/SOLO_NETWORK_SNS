import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_repository_impl.dart';

abstract interface class CommentRepository {
  Future<void> createComment(CommentEntity commentEntity);

}

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  return CommentRepositoryImpl(
      FirebaseFirestore.instance, FirebaseStorage.instance);
});
