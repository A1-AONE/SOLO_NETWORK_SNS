import 'package:solo_network_sns/data/dto/ai_dto.dart';

abstract interface class AiDataSource { 
  Future<List<AiDto>> fetchAi();
}