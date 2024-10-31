// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../data/models/qr_code_model.dart';
import 'qr_code_widget.dart';

class QrCodeItemListWidget extends StatelessWidget {
  const QrCodeItemListWidget({
    super.key,
    required this.qrCode,
  });
  final QrCodeModel qrCode;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).shadowColor,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
          border: Border.all(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: QrCodeWidget(
                    qrCodeModel: qrCode,
                    backgroundPadding: 8,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(
                    qrCode.type,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    qrCode.comment,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
