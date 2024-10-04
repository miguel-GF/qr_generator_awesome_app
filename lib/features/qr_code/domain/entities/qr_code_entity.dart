import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QrCodeEntity extends Equatable {
  final String id;
  final String type;
  final String data;
  final String description;
  final double size;
  final double padding;
  final bool gapless;
  final String eyeType;
  final String pointType;
  final Color backgroundColor;
  final Color eyeColor;
  final Color pointColor;

  const QrCodeEntity({
    required this.id,
    required this.type,
    required this.data,
    this.description = '',
    this.size = double.infinity,
    this.padding = 16,
    this.gapless = true,
    this.eyeType = 'square',
    this.pointType = 'square',
    this.backgroundColor = Colors.transparent,
    this.eyeColor = Colors.black,
    this.pointColor = Colors.black,
  });

  @override
  List<Object> get props {
    return [
      id,
      type,
      data,
      description,
      size,
      padding,
      backgroundColor,
      gapless,
      eyeType,
      pointType,
      backgroundColor,
      eyeColor,
      pointColor,
    ];
  }
}
