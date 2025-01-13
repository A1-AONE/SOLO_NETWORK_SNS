import 'package:solo_network_sns/data/repository_imple/ai_repository_impl.dart';
import 'package:solo_network_sns/domain/entitiy/ai_entitiy.dart';

class AiUserCase {
  AiUserCase();

  Future<List<AiEntity>> fetchAiExecute() async{
    final aiRepository = AiRepositoryimpl();
    return await aiRepository.getAiData();
  }
}