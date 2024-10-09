import 'package:flutter/material.dart';

import '../../data/models/qr_code_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({
    super.key,
    required this.qrCodeModel,
  });
  final QrCodeModel qrCodeModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: qrCodeModel.backgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: QrImageView(
        key: Key(qrCodeModel.id),
        data: qrCodeModel.data,
        gapless: qrCodeModel.gapless,
        backgroundColor: qrCodeModel.qrBackgroundColor,
        padding: EdgeInsets.all(qrCodeModel.padding),
        eyeStyle: QrEyeStyle(
          color: qrCodeModel.eyeColor,
          eyeShape: qrCodeModel.eyeType == 'square'
              ? QrEyeShape.square
              : QrEyeShape.circle,
        ),
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: qrCodeModel.pointType == 'square'
              ? QrDataModuleShape.square
              : QrDataModuleShape.circle,
          color: qrCodeModel.pointColor,
        ),
        errorStateBuilder: (context, error) {
          // Aquí defines lo que se mostrará en caso de error
          return Center(
            child: Container(
              color: Colors.red,
              child: Text(
                'Error al generar el QR: ${error.toString()}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
