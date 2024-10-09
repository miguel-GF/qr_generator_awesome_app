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
      gapless: json['gapless'] as bool? ?? true,
      eyeType: json['eyeType'] as String? ?? 'square',
      pointType: json['pointType'] as String? ?? 'square',
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
      hidden: json['hidden'] as bool?,
      eventTitle: json['eventTitle'] as String?,
      eventStartDate: json['eventStartDate'] == null
          ? null
          : DateTime.parse(json['eventStartDate'] as String),
      eventEndDate: json['eventEndDate'] == null
          ? null
          : DateTime.parse(json['eventEndDate'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as String?),
      eyeColor: const ColorConverter().fromJson(json['eyeColor'] as String?),
      pointColor:
          const ColorConverter().fromJson(json['pointColor'] as String?),
      qrBackgroundColor:
          const ColorConverter().fromJson(json['qrBackgroundColor'] as String?),
    );

Map<String, dynamic> _$QrCodeModelToJson(QrCodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'data': instance.data,
      'comment': instance.comment,
      'size': instance.size,
      'padding': instance.padding,
      'gapless': instance.gapless,
      'eyeType': instance.eyeType,
      'pointType': instance.pointType,
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
      'hidden': instance.hidden,
      'eventTitle': instance.eventTitle,
      'eventStartDate': instance.eventStartDate?.toIso8601String(),
      'eventEndDate': instance.eventEndDate?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'eyeColor': const ColorConverter().toJson(instance.eyeColor),
      'pointColor': const ColorConverter().toJson(instance.pointColor),
      'qrBackgroundColor':
          const ColorConverter().toJson(instance.qrBackgroundColor),
    };
