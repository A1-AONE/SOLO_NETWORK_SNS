import 'package:solo_network_sns/domain/entitiy/ai_entitiy.dart';

abstract interface class AiRepository {
  Future<List<AiEntity>> getAiData();
}