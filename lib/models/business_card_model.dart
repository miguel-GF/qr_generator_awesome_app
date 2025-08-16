// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';

class BusinessCardModel {
  final String businessCardId; // ID primaria
  final String qrCodeId; // ID del QR Code asociado (clave foránea)
  final String mainText;
  final String? secondaryText; // Puede ser nulo
  final int layoutType; // 1, 2, 3, 4 (el índice del layout seleccionado)

  // Parámetros para recrear el BoxDecoration
  final bool isGradient;
  final int color1Value; // Guardamos el valor entero del color (ARGB)
  final int? color2Value; // Para degradado, puede ser nulo para color sólido
  final String?
      gradientDirection; // 'leftToRight', 'topToBottom', 'centerOut', etc.
  String? favorite; // 'si', 'no'

  BusinessCardModel({
    required this.businessCardId,
    required this.qrCodeId,
    required this.mainText,
    this.secondaryText,
    required this.layoutType,
    required this.isGradient,
    required this.color1Value,
    this.color2Value,
    this.gradientDirection,
    this.favorite,
  });

  // Constructor para crear un BusinessCardModel desde un mapa (ej. desde la base de datos)
  factory BusinessCardModel.fromJson(Map<String, dynamic> json) {
    return BusinessCardModel(
      businessCardId: json['business_card_id'] as String,
      qrCodeId: json['qr_code_id'] as String,
      mainText: json['main_text'] as String,
      secondaryText: json['secondary_text'] as String?,
      layoutType: json['layout_type'] as int,
      isGradient: json['is_gradient'] ==
          1, // SQLite guarda BOOLEAN como INTEGER (0 o 1)
      color1Value: json['color1_value'] as int,
      color2Value: json['color2_value'] as int?,
      gradientDirection: json['gradient_direction'] as String?,
      favorite: json['favorite'] as String? ?? 'no',
    );
  }

  // Convierte el objeto BusinessCardModel a un mapa para guardarlo en la base de datos
  Map<String, dynamic> toJson() {
    return {
      'business_card_id': businessCardId,
      'qr_code_id': qrCodeId,
      'main_text': mainText,
      'secondary_text': secondaryText,
      'layout_type': layoutType,
      'is_gradient': isGradient ? 1 : 0, // Guarda BOOLEAN como INTEGER
      'color1_value': color1Value,
      'color2_value': color2Value,
      'gradient_direction': gradientDirection,
      'favorite': favorite,
    };
  }

  // **Método de Negocio:** Reconstruye el BoxDecoration a partir de los datos del modelo
  BoxDecoration toBoxDecoration() {
    final Color color1 = Color(color1Value);
    final Color? color2 = color2Value != null ? Color(color2Value!) : null;

    // Estos mapas de alineación deben ser consistentes con los usados en BusinessCardCreateStepTwoScreen
    final Map<String, Alignment> beginAlignments = {
      'leftToRight': Alignment.centerLeft,
      'rightToLeft': Alignment.centerRight,
      'topToBottom': Alignment.topCenter,
      'bottomToTop': Alignment.bottomCenter,
      'centerOut': Alignment
          .center, // Para degradado radial, begin/end no son relevantes aquí
    };

    final Map<String, Alignment> endAlignments = {
      'leftToRight': Alignment.centerRight,
      'rightToLeft': Alignment.centerLeft,
      'topToBottom': Alignment.bottomCenter,
      'bottomToTop': Alignment.topCenter,
      'centerOut': Alignment.center, // Para degradado radial
    };

    if (isGradient && gradientDirection == 'centerOut' && color2 != null) {
      return BoxDecoration(
        gradient: RadialGradient(
          colors: [color1, color2],
          radius: 1.0,
        ),
      );
    } else if (isGradient && color2 != null) {
      return BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          // Usa el valor del mapa o un valor por defecto si no se encuentra (aunque no debería pasar)
          begin: beginAlignments[gradientDirection!] ?? Alignment.centerLeft,
          end: endAlignments[gradientDirection!] ?? Alignment.centerRight,
        ),
      );
    } else {
      return BoxDecoration(color: color1);
    }
  }
}
