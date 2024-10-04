import 'package:flutter/material.dart';

class InputAddNewData extends StatelessWidget {
  const InputAddNewData({
    super.key,
    required this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength = 50,
    this.labelText = '',
    this.hintText = '',
    this.validator,
  });
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
