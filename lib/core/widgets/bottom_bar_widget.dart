import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    super.key,
    this.labelBtn,
    this.function,
  });
  final String? labelBtn;
  final VoidCallback? function;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TextButton(
          onPressed: function,
          child: Text(
            labelBtn!.isNotEmpty ? labelBtn!.toUpperCase() : 'SIGUIENTE',
          ),
        ),
      ),
    );
  }
}
