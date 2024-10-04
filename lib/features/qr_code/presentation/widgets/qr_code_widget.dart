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
    return QrImageView(
      key: Key(qrCodeModel.id),
      data: qrCodeModel.data,
      gapless: qrCodeModel.gapless,
      backgroundColor: qrCodeModel.backgroundColor,
      padding: EdgeInsets.all(qrCodeModel.padding),
      size: qrCodeModel.size,
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
    );
  }
}
