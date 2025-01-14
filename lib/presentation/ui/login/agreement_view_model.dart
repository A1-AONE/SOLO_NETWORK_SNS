import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/domain/usecase/agreement_use_case.dart';
import 'package:solo_network_sns/presentation/providers.dart';

class AgreementViewModel extends StateNotifier<String> {
  final AgreementUseCase _agreementUseCase;

  AgreementViewModel(this._agreementUseCase) : super('');

  Future<void> loadText() async {
    try {
      final text = await _agreementUseCase();
      state = text;
    } catch (e) {
      state = '에러가 발생했습니다! $e';
    }
  }
}

final agreementViewModelProvider =
    StateNotifierProvider<AgreementViewModel, String>(
        (ref) => AgreementViewModel(ref.read(agreementUseCaseProvider)));
