import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/data/repository_imple/user_repository_impl.dart';
import 'package:solo_network_sns/data/source/user_data_source.dart';
import 'package:solo_network_sns/data/source/user_data_source_impl.dart';
import 'package:solo_network_sns/domain/repository/user/user_repository.dart';
import 'package:solo_network_sns/domain/usecase/user_usecase.dart';

final userDataSouceProvider = Provider<UserDataSource>((ref){
  return UserDataSourceImpl();
});

final userRepositoryProvider = Provider<UserRepository>((ref){
  final datasource = ref.read(userDataSouceProvider);
  return UserRepositoryImpl(datasource);
});

final fetchUserUsecaseProvider = Provider((ref) {
  final userRepo = ref.read(userRepositoryProvider);
  return UserUsecase(userRepo);
});