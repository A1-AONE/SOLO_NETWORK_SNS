import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/data/dto/ai_dto.dart';
import 'package:solo_network_sns/data/source/ai_data_source.dart';

class AiDataSourceImpl implements AiDataSource {
  @override
  Future<List<AiDto>> fetchAi() async {
        try {
      //1. 파이어스토어 인스턴스 가지고오기
      final firestore = FirebaseFirestore.instance;
      //2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection('AI');
      //3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        return AiDto.fromJson(map);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}