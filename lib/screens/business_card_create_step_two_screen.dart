import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/widgets/bottom_bar_widget.dart';
import '../features/qr_code/data/models/qr_code_model.dart';

class BusinessCardCreateStepTwoScreen extends StatefulWidget {
  const BusinessCardCreateStepTwoScreen({super.key});

  @override
  State<BusinessCardCreateStepTwoScreen> createState() =>
      _BusinessCardCreateStepTwoScreenState();
}

class _BusinessCardCreateStepTwoScreenState
    extends State<BusinessCardCreateStepTwoScreen> {
  late final QrCodeModel cardQrCodeStepOne;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    cardQrCodeStepOne = QrCodeModel.fromJson(arguments['cardQrCodeStepOne']);
    print('id qr');
    print(cardQrCodeStepOne.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('paso 2 creacion card'),
      ),
      body: Center(
        child: Text(cardQrCodeStepOne.id.toString()),
      ),
      // BottomNavigationBar con el botón de siguiente
      bottomNavigationBar: Visibility(
        child: BottomBarWidget(
          labelBtn: 'Checar',
          function: () async => {},
        ),
      ),
    );
  }
}
