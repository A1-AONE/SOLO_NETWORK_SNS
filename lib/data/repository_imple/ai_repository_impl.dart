
import 'package:solo_network_sns/data/source/ai_data_source_impl.dart';
import 'package:solo_network_sns/domain/entitiy/ai_entitiy.dart';
import 'package:solo_network_sns/domain/repository/ai_repository.dart';

class AiRepositoryimpl implements AiRepository {
  @override
  Future<List<AiEntity>> getAiData() async {
    final aiDataSource = AiDataSourceImpl();
    final result = await aiDataSource.fetchAi();
    final newResult = result.map((e){
      return AiEntity(ai: e.ai, nickName: e.nickName, profileUrl: e.profileUrl);
    }).toList();

    return newResult;
  }
}