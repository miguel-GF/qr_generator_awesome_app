import '../../domain/entities/qr_code_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'qr_code_model.g.dart';

@JsonSerializable()
class QrCodeModel extends QrCodeEntity {
  const QrCodeModel({
    required super.id,
  });
  factory QrCodeModel.fromJson(Map<String, dynamic> data) =>
      _$QrCodeModelFromJson(data);
  Map<String, dynamic> toJson() => _$QrCodeModelToJson(this);
}
