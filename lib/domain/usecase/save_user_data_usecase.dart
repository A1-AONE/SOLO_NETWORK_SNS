import 'dart:io';

import 'package:solo_network_sns/data/dto/user_profile_dto.dart';
import 'package:solo_network_sns/domain/entitiy/user_profile_entity.dart';
import 'package:solo_network_sns/domain/repository/user_profile_repository.dart';

class SaveUserDataUseCase {
  final UserProfileRepository _repository;

  SaveUserDataUseCase(this._repository);

  Future<void> call(UserProfileEntity userData, {File? imageFile}) async {
    await _repository.saveUserData(
      userData,
    );
  }
}
