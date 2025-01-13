import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:solo_network_sns/presentation/ui/login/agreement_view_model.dart';

class AgreementModal extends ConsumerWidget {
  const AgreementModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreementText = ref.watch(agreementViewModelProvider);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        // mainAxisAlignment: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 45),
              Text(
                '개인정보 수집 이용 동의',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
                child: agreementText.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                        agreementText,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}
