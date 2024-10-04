import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String?> {
  const ColorConverter();

  @override
  Color fromJson(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return Colors.transparent; // Valor por defecto
    }
    final values = colorString.split(',').map(int.parse).toList();
    if (values.length == 4) {
      return Color.fromRGBO(values[0], values[1], values[2], values[3] / 255);
    }
    return Colors.transparent; // Valor por defecto si no es válido
  }

  @override
  String? toJson(Color? color) {
    if (color == null) {
      return null;
    }
    return '${color.red},${color.green},${color.blue},${color.alpha}';
  }
}
