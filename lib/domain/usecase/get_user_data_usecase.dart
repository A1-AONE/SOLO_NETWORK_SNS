import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';

class GetUserDataUseCase {
  final UserProfileRepository repository;

  GetUserDataUseCase(this.repository);

  Future<UserProfileEntity> call(String uid) async {
    return await repository.getUserData(uid);
  }
}
