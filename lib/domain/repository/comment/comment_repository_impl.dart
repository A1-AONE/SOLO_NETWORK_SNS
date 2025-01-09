
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:solo_network_sns/domain/entitiy/comment_entity.dart';
import 'package:solo_network_sns/domain/repository/comment/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  CommentRepositoryImpl(this.firestore, this.storage);

  @override
  Future<void> createComment(CommentEntity commentEntity) async{
    await firestore.collection('Comment').doc().set({
      'AI': commentEntity.ai,
      'comment': commentEntity.comment,
      'createdAt': commentEntity.createdAt,
      'feed_id': commentEntity.feed_id,
      'goods': commentEntity.goods,
      'user_id': commentEntity.user_id,
    });
  }

}
