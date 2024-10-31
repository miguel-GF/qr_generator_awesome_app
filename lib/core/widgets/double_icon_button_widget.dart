import 'package:flutter/material.dart';

class DoubleIconButtonWidget extends StatelessWidget {
  const DoubleIconButtonWidget({
    super.key,
    this.onTap,
    this.iconMain = Icons.qr_code_2,
    this.iconSecondary = Icons.add_circle,
    this.color,
  });
  final VoidCallback? onTap;
  final IconData iconMain;
  final IconData iconSecondary;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap!,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Theme.of(context).hintColor),
              borderRadius: BorderRadius.circular(10),
              color: color ?? Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                iconMain,
                size: 42,
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                iconSecondary,
                size: 18,
                color: color ?? Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
