import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../features/qr_code/data/models/qr_code_model.dart';
// import '../../features/qr_code/presentation/widgets/qr_code_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('hola'),
    );
    // QrCodeModel qrCode = const QrCodeModel(
    //   id: '#4rfty',
    //   type: 'text',
    //   data: 'HOLA MIKE HOLA MIKE / wifjiqfjqmfi / 92349238',
    // );
    // return Column(
    //   children: [
    //     SizedBox(
    //       width: Get.width * 0.4,
    //       child: QrCodeWidget(qrCodeModel: qrCode),
    //     ),
    //   ],
    // );
  }
}
