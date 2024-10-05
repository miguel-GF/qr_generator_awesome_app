// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class QrCodeEntity extends Equatable {
  final String id;
  final String type;
  final String data;
  final String comment;
  final double size;
  final double padding;
  final bool gapless;
  final String eyeType;
  final String pointType;
  final Color backgroundColor;
  final Color eyeColor;
  final Color pointColor;

  // Propiedades comunes compartidas
  final String? phone; // Usado para WhatsApp, SMS, Teléfono
  final String? message; // Usado para WhatsApp, SMS, Email (mensaje en cuerpo del correo)
  final String? url; // Usado para Link, Twitter, YouTube, App Store/Play Store, etc.
  final String? description; // Usado para descripción general (Link, Evento, etc.)

  // Texto simple
  final String? text; // Solo para el QR de texto

  // Contacto (vCard o MECARD)
  final String? firstName; // Nombre del contacto
  final String? lastName; // Apellido del contacto
  final String? email; // Usado para contacto (email del contacto) y correo electrónico (destinatario)
  final String? address; // Dirección del contacto
  final String? city; // Ciudad del contacto
  final String? country; // País del contacto
  final String? enterprise; // Empresa del contacto
  final String? note; // Nota adicional sobre el contacto

  // Email (además de message y email que ya son compartidos)
  final String? subject; // Asunto del correo electrónico

   // WiFi
  final String? ssid; // Nombre de la red WiFi
  final String? password; // Contraseña de la red WiFi
  final String? encryption; // Tipo de cifrado (WEP, WPA, etc.)
  final bool? hidden; // Indica si la red WiFi es oculta

  // Evento (vCalendar)
  final String? eventTitle; // Título del evento
  final DateTime? eventStartDate; // Fecha de inicio del evento
  final DateTime? eventEndDate; // Fecha de finlización del evento

  // Ubicación
  final double? latitude; // Latitud para la ubicación
  final double? longitude; // Longitud para la ubicación
  
  // Redes sociales (URL reutilizada para varias plataformas)
  // Twitter, YouTube, App Store/Play Store, y otras plataformas utilizan la propiedad url

  const QrCodeEntity({
    required this.id,
    required this.type,
    required this.data,
    this.comment = '',
    this.size = double.infinity,
    this.padding = 16,
    this.gapless = true,
    this.eyeType = 'square',
    this.pointType = 'square',
    this.backgroundColor = Colors.transparent,
    this.eyeColor = Colors.black,
    this.pointColor = Colors.black,
    this.phone,
    this.message,
    this.url,
    this.description,
    this.text,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.city,
    this.country,
    this.enterprise,
    this.note,
    this.subject,
    this.ssid,
    this.password,
    this.encryption,
    this.hidden,
    this.eventTitle,
    this.eventStartDate,
    this.eventEndDate,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object> get props {
    return [
      id,
      type,
      data,
      comment,
      size,
      padding,
      gapless,
      eyeType,
      pointType,
      backgroundColor,
      eyeColor,
      pointColor,
      phone!,
      message!,
      url!,
      description!,
      text!,
      firstName!,
      lastName!,
      email!,
      address!,
      city!,
      country!,
      enterprise!,
      note!,
      subject!,
      ssid!,
      password!,
      encryption!,
      hidden!,
      eventTitle!,
      eventStartDate!,
      eventEndDate!,
      latitude!,
      longitude!,
    ];
  }
}
