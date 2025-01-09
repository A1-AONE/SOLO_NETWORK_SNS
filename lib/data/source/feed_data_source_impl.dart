import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/data/dto/feed_dto.dart';
import 'package:solo_network_sns/data/source/feed_data_source.dart';

class FeedDataSourceImpl implements FeedDataSource {
  @override
  Future<List<FeedDto>> fetchFeeds() async{
    try {
      //1. 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('Feed');
      //3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        doc.id;
        final newMap = {
          'id': doc.id,
          ...map,
        };
        return FeedDto.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
  
  @override
  Stream<List<FeedDto>> streamFeeds() {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('Feed');

      final stream = collectionRef.snapshots();

      final newStream = stream.map((snapshot){
        final docs = snapshot.docs.map((doc) {
          final map = doc.data();
          final newMap = {
            'id': doc.id,
            ...map,
          };
          return FeedDto.fromJson(newMap);
        }).toList();
        
        return docs;
      });

      return newStream;
  }
}