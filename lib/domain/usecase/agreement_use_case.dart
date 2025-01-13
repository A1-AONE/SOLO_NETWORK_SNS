import 'package:solo_network_sns/domain/repository/agreement_repository.dart';

class AgreementUseCase {
  final AgreementRepository _repository;

  AgreementUseCase(this._repository);

  Future<String> call() async {
    return await _repository.fetchAgreementText();
  }
}
