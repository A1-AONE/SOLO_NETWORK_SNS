import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/data/dto/user_dto.dart';
import 'package:solo_network_sns/data/source/user_data_source.dart';

class UserDataSourceImpl implements UserDataSource {
  @override
  Future<List<UserDto>> fetchUser() async {
    try {
      //1. 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('User');

      //3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        return UserDto.fromJson(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }
  
  @override
  Stream<List<UserDto>> streamUsers() {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('User');

      final stream = collectionRef.snapshots();

      final newStream = stream.map((snapshot){
        final docs = snapshot.docs.map((doc) {
          final map = doc.data();
          return UserDto.fromJson(map);
        }).toList();
        
        return docs;
      });

      return newStream;
  }
}
