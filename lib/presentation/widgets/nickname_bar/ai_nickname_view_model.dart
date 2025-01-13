import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/entitiy/ai_entitiy.dart';
import 'package:solo_network_sns/domain/usecase/ai_user_case.dart';

class AiNicknameViewModel extends Notifier<List<AiEntity>?> {
  @override
  List<AiEntity>? build() {
    fetchAi();
    return null;
  }

  // Ai 데이터를 가져오는 비동기 메서드
  Future<void> fetchAi() async {
    try {
      final aiUserCase = AiUserCase();
      final data = await aiUserCase.fetchAiExecute();

      state = data;
    } catch (e) {
      state = [];
    }
  }
}

final aiNicknameViewModel =
    NotifierProvider<AiNicknameViewModel, List<AiEntity>?>(
  () => AiNicknameViewModel(),
);