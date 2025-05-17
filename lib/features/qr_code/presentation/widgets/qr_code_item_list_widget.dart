// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/qr_code_model.dart';
import 'qr_code_widget.dart';

class QrCodeItemListWidget extends StatelessWidget {
  const QrCodeItemListWidget({
    super.key,
    required this.qrCode,
    this.onFavorite,
    this.onSelected,
    this.showVaforite = true,
    this.isSelected = false,
  });
  final QrCodeModel qrCode;
  final VoidCallback? onFavorite;
  final VoidCallback? onSelected;
  final bool showVaforite;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Material(
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
            border: Border.all(
              color: isSelected ? Colors.blue : Theme.of(context).hintColor,
              width: isSelected ? 3 : 1.0,
            ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              qrCode.type,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: showVaforite,
                            child: InkWell(
                              onTap: onFavorite,
                              child: Icon(
                                qrCode.favorite == 'no'
                                    ? FontAwesomeIcons.heart
                                    : FontAwesomeIcons.solidHeart,
                                color:
                                    qrCode.favorite == 'no' ? null : Colors.red,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            qrCode.comment,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
