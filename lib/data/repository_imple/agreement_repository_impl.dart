import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solo_network_sns/domain/repository/agreement_repository.dart';

class AgreementRepositoryImpl implements AgreementRepository {
  @override
  Future<String> fetchAgreementText() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Agreement')
          .doc('default')
          .get();
      return snapshot['text'] ?? '내용을 불러올 수 없습니다!';
    } catch (e) {
      throw Exception('데이터 로드 오류: $e');
    }
  }
}
