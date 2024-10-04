// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/qr_code_entity.dart';
import 'color_converter.dart';

part 'qr_code_model.g.dart';

@JsonSerializable()
class QrCodeModel extends QrCodeEntity {
  @override
  @ColorConverter()
  final Color backgroundColor;

  @override
  @ColorConverter()
  final Color eyeColor;

  @override
  @ColorConverter()
  final Color pointColor;

  const QrCodeModel({
    required super.id,
    required super.type,
    required super.data,
    super.description,
    super.size,
    super.padding,
    super.gapless,
    super.eyeType,
    super.pointType,
    required this.backgroundColor,
    required this.eyeColor,
    required this.pointColor,
  }) : super(
          backgroundColor: backgroundColor,
          eyeColor: eyeColor,
          pointColor: pointColor,
        );

  factory QrCodeModel.fromJson(Map<String, dynamic> data) =>
      _$QrCodeModelFromJson(data);

  Map<String, dynamic> toJson() => _$QrCodeModelToJson(this);
}
