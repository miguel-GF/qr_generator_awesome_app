// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrCodeModel _$QrCodeModelFromJson(Map<String, dynamic> json) => QrCodeModel(
      id: json['id'] as String,
      type: json['type'] as String,
      data: json['data'] as String,
      comment: json['comment'] as String? ?? '',
      size: (json['size'] as num?)?.toDouble() ?? double.infinity,
      padding: (json['padding'] as num?)?.toDouble() ?? 16,
      gapless: json['gapless'] == null
          ? true
          : const BoolIntConverter().fromJson((json['gapless'] as num).toInt()),
      eyeType: json['eye_type'] as String? ?? 'square',
      pointType: json['point_type'] as String? ?? 'square',
      phone: json['phone'] as String?,
      message: json['message'] as String?,
      url: json['url'] as String?,
      description: json['description'] as String?,
      text: json['text'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      enterprise: json['enterprise'] as String?,
      note: json['note'] as String?,
      subject: json['subject'] as String?,
      ssid: json['ssid'] as String?,
      password: json['password'] as String?,
      encryption: json['encryption'] as String?,
      hidden: _$JsonConverterFromJson<int, bool>(
          json['hidden'], const BoolIntConverter().fromJson),
      eventTitle: json['event_title'] as String?,
      eventStartDate: json['event_start_date'] == null
          ? null
          : DateTime.parse(json['event_start_date'] as String),
      eventEndDate: json['event_end_date'] == null
          ? null
          : DateTime.parse(json['event_end_date'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      backgroundColor:
          const ColorConverter().fromJson(json['background_color'] as String?),
      eyeColor: const ColorConverter().fromJson(json['eye_color'] as String?),
      pointColor:
          const ColorConverter().fromJson(json['point_color'] as String?),
      qrBackgroundColor: const ColorConverter()
          .fromJson(json['qr_background_color'] as String?),
    );

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'comment': instance.comment,
      'size': instance.size,
      'padding': instance.padding,
      'eye_type': instance.eyeType,
      'point_type': instance.pointType,
      'phone': instance.phone,
      'message': instance.message,
      'url': instance.url,
      'description': instance.description,
      'email': instance.email,
      'text': instance.text,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'enterprise': instance.enterprise,
      'note': instance.note,
      'subject': instance.subject,
      'ssid': instance.ssid,
      'password': instance.password,
      'encryption': instance.encryption,
      'event_title': instance.eventTitle,
      'event_start_date': instance.eventStartDate?.toIso8601String(),
      'event_end_date': instance.eventEndDate?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'background_color':
          const ColorConverter().toJson(instance.backgroundColor),
      'eye_color': const ColorConverter().toJson(instance.eyeColor),
      'point_color': const ColorConverter().toJson(instance.pointColor),
      'qr_background_color':
          const ColorConverter().toJson(instance.qrBackgroundColor),
      'gapless': const BoolIntConverter().toJson(instance.gapless),
      'hidden': const BoolIntConverter().toJson(instance.hidden),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
