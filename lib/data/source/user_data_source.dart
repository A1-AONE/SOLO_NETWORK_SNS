import 'package:solo_network_sns/data/dto/user_dto.dart';

abstract interface class UserDataSource { 
  Future<List<UserDto>> fetchUser();

}