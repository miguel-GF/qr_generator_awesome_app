// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../../data/models/qr_code_model.dart';
import 'qr_code_widget.dart';

class QrCodeItemTileWidget extends StatelessWidget {
  const QrCodeItemTileWidget({
    super.key,
    required this.qrCode,
  });
  final QrCodeModel qrCode;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).hintColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(qrCode.type),
                    SizedBox(height: 8),
                    Text(
                      qrCode.comment + qrCode.comment,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(
                        10,
                      ),
                      bottomRight: Radius.circular(
                        10,
                      ),
                    ),
                    child: QrCodeWidget(
                      qrCodeModel: qrCode,
                      backgroundPadding: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
