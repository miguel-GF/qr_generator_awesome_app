// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessCardModel _$BusinessCardModelFromJson(Map<String, dynamic> json) =>
    BusinessCardModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      layout: (json['layout'] as num).toInt(),
      qrCodeId: (json['qr_code_id'] as num).toInt(),
      backgroundColor: json['background_color'] as String,
    );

Map<String, dynamic> _$BusinessCardModelToJson(BusinessCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'layout': instance.layout,
      'qr_code_id': instance.qrCodeId,
      'background_color': instance.backgroundColor,
    };
