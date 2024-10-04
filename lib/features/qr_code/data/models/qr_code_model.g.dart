// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel(
      id: json['id'] as String,
      type: json['type'] as String,
      data: json['data'] as String,
      description: json['description'] as String? ?? '',
      size: (json['size'] as num?)?.toDouble() ?? double.infinity,
      padding: (json['padding'] as num?)?.toDouble() ?? 16,
      gapless: json['gapless'] as bool? ?? true,
      eyeType: json['eyeType'] as String? ?? 'square',
      pointType: json['pointType'] as String? ?? 'square',
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as String?),
      eyeColor: const ColorConverter().fromJson(json['eyeColor'] as String?),
      pointColor:
          const ColorConverter().fromJson(json['pointColor'] as String?),
    );

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'description': instance.description,
      'size': instance.size,
      'padding': instance.padding,
      'gapless': instance.gapless,
      'eyeType': instance.eyeType,
      'pointType': instance.pointType,
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'eyeColor': const ColorConverter().toJson(instance.eyeColor),
      'pointColor': const ColorConverter().toJson(instance.pointColor),
    };
