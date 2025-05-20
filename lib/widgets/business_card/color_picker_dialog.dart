import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color currentColor;
  final Function(Color) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.currentColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona un color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: currentColor,
          onColorChanged: onColorSelected,
          availableColors: const [
            Colors.transparent,
            Colors.red,
            Colors.purple,
            Colors.orange,
            Colors.blue,
            Colors.green,
            Colors.yellow,
            Colors.pink,
            Colors.teal,
            Colors.cyan,
            Colors.amber,
            Colors.lime,
            Colors.brown,
            Colors.grey,
            Colors.black,
            Colors.white,
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
