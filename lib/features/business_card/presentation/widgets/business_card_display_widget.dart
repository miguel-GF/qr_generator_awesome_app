// lib/features/business_card/presentation/widgets/business_card_display_widget.dart
// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_awesome_generator/features/qr_code/data/models/qr_code_model.dart'; // Importa tu modelo de QR Code
import 'package:qr_awesome_generator/features/qr_code/presentation/widgets/qr_code_widget.dart';
import 'package:qr_awesome_generator/models/business_card_model.dart'; // Importa tu widget de QR Code

class BusinessCardDisplayWidget extends StatelessWidget {
  final BusinessCardModel businessCard;
  final QrCodeModel qrCode; // Ahora recibimos el QrCodeModel completo
  final VoidCallback? onFavorite;
  final bool showVaforite;

  const BusinessCardDisplayWidget({
    super.key,
    required this.businessCard,
    required this.qrCode,
    this.onFavorite,
    this.showVaforite = false,
  });

  // Helper para construir el placeholder del QR Code
  // Reutiliza la lógica de la pantalla de selección de layout
  Widget _buildQrCodePlaceholder() {
    return Container(
      width: 80, // Tamaño consistente para el QR en la tarjeta
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: QrCodeWidget(
          qrCodeModel: qrCode, // Pasa el QrCodeModel recibido
          backgroundPadding: 7,
        ),
      ),
    );
  }

  // Estilos de texto comunes para mejorar la consistencia
  TextStyle _mainTextStyle(Color textColor) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: textColor,
        shadows: const [
          Shadow(blurRadius: 3, color: Colors.black54, offset: Offset(1, 1))
        ],
      );

  TextStyle _secondaryTextStyle(Color textColor) => TextStyle(
        fontSize: 14,
        color: textColor.withOpacity(0.7), // Ligeramente más transparente
        shadows: const [
          Shadow(blurRadius: 3, color: Colors.black54, offset: Offset(1, 1))
        ],
      );

  Widget _buildCardLayout1(BuildContext context, BoxDecoration decoration) {
    // Clásico y Minimalista
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity, // Ancho de la tarjeta
        height: 182, // Alto de la tarjeta (aprox. proporción 1.75:1)
        decoration: decoration, // El fondo dinámico
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                businessCard.mainText,
                style: _mainTextStyle(Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                businessCard.secondaryText ??
                    '', // Usa ?? '' para manejar el nulo
                style: _secondaryTextStyle(Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(), // Empuja el QR a la esquina
              Align(
                alignment: Alignment.bottomRight,
                child: _buildQrCodePlaceholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardLayout2(BuildContext context, BoxDecoration decoration) {
    // Moderno y Dinámico
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      businessCard.mainText,
                      textAlign: TextAlign.center,
                      style: _mainTextStyle(Colors.white)
                          .copyWith(fontSize: 24, fontWeight: FontWeight.w900),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text(
                      businessCard.secondaryText ?? '',
                      textAlign: TextAlign.center,
                      style: _secondaryTextStyle(Colors.white)
                          .copyWith(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15), // Espacio entre texto y QR
              _buildQrCodePlaceholder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardLayout3(BuildContext context, BoxDecoration decoration) {
    // Estructurado con Franja
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: decoration,
        child: Row(
          children: [
            Expanded(
              flex: 3, // Más espacio para el texto
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      businessCard.mainText,
                      style:
                          _mainTextStyle(Colors.white).copyWith(fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      businessCard.secondaryText ?? '',
                      style: _secondaryTextStyle(Colors.white)
                          .copyWith(fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Franja de separación
            Container(
              width: 2,
              color: Colors.white.withOpacity(0.5),
            ),
            Expanded(
              flex: 2, // Menos espacio para el QR
              child: Center(
                child: _buildQrCodePlaceholder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardLayout4(BuildContext context, BoxDecoration decoration) {
    // Creativo y Asimétrico
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: double.infinity,
        height: 180,
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  businessCard.mainText,
                  style: _mainTextStyle(Colors.white).copyWith(fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              _buildQrCodePlaceholder(), // QR en el centro
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  businessCard.secondaryText ?? '',
                  textAlign: TextAlign.right,
                  style:
                      _secondaryTextStyle(Colors.white).copyWith(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reconstruye el BoxDecoration a partir de los
    // datos guardados en BusinessCardModel
    final BoxDecoration cardDecoration = businessCard.toBoxDecoration();

    // Selecciona el layout correcto basado en businessCard.layoutType
    switch (businessCard.layoutType) {
      case 1:
        return Stack(children: [
          _buildCardLayout1(context, cardDecoration),
          Positioned(
            top: 12,
            right: 12,
            child: Visibility(
              visible: showVaforite,
              child: InkWell(
                onTap: onFavorite,
                child: Icon(
                  businessCard.favorite == 'no'
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: businessCard.favorite == 'no' ? null : Colors.red,
                  size: 26,
                ),
              ),
            ),
          ),
        ]);
      case 2:
        return Stack(children: [
          _buildCardLayout2(context, cardDecoration),
          Positioned(
            top: 12,
            right: 12,
            child: Visibility(
              visible: showVaforite,
              child: InkWell(
                onTap: onFavorite,
                child: Icon(
                  businessCard.favorite == 'no'
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: businessCard.favorite == 'no' ? null : Colors.red,
                  size: 26,
                ),
              ),
            ),
          ),
        ]);
      case 3:
        return Stack(children: [
          _buildCardLayout3(context, cardDecoration),
          Positioned(
            top: 12,
            right: 12,
            child: Visibility(
              visible: showVaforite,
              child: InkWell(
                onTap: onFavorite,
                child: Icon(
                  businessCard.favorite == 'no'
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: businessCard.favorite == 'no' ? null : Colors.red,
                  size: 26,
                ),
              ),
            ),
          ),
        ]);
      case 4:
        return Stack(children: [
          _buildCardLayout4(context, cardDecoration),
          Positioned(
            top: 12,
            right: 12,
            child: Visibility(
              visible: showVaforite,
              child: InkWell(
                onTap: onFavorite,
                child: Icon(
                  businessCard.favorite == 'no'
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: businessCard.favorite == 'no' ? null : Colors.red,
                  size: 26,
                ),
              ),
            ),
          ),
        ]);
      default:
        // Mensaje de fallback si el layoutType no es reconocido
        return Center(
          child: Text(
              'Error: Layout tipo ${businessCard.layoutType} no soportado.'),
        );
    }
  }
}
