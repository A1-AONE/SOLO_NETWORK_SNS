import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/data/dto/comment_dto.dart';
import 'package:solo_network_sns/data/source/comment_data_source.dart';

class CommentDataSourceImpl implements CommentDataSource{
  @override
  Future<List<CommentDto>> fetchComments() async{
    try {
      //1. 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('Comment');
      //3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        return CommentDto.fromJson(map);
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Stream<List<CommentDto>> streamComments() {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('Comment');

      final stream = collectionRef.snapshots();

      final newStream = stream.map((snapshot){
        final docs = snapshot.docs.map((doc) {
          final map = doc.data();
          return CommentDto.fromJson(map);
        }).toList();
        
        return docs;
      });

      return newStream;
  }
}