import 'package:solo_network_sns/domain/entitiy/user_entity.dart';
import 'package:solo_network_sns/domain/repository/user_repository.dart';

class GetUserDataUseCase {
  final UserRepository repository;

  GetUserDataUseCase(this.repository);

  Future<UserEntity> call(String uid) async {
    return await repository.getUserData(uid);
  }
}
