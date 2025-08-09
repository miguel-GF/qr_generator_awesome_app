import 'package:json_annotation/json_annotation.dart';

part 'business_card_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BusinessCardModel {
  final int? id;
  final String title;
  final String subtitle;
  final int layout;
  final int qrCodeId;
  final String backgroundColor; // Guardado como string HEX

  BusinessCardModel({
    this.id,
    required this.title,
    required this.subtitle,
    required this.layout,
    required this.qrCodeId,
    required this.backgroundColor,
  });

  factory BusinessCardModel.fromJson(Map<String, dynamic> data) =>
      _$BusinessCardModelFromJson(data);

  Map<String, dynamic> toJson() => _$BusinessCardModelToJson(this);
}
