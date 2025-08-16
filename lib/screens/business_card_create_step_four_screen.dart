// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/database/local/business_card_database_helper.dart';
import '../core/routes/routes_names.dart';
import '../core/utils/string_util.dart';
import '../core/widgets/bottom_bar_widget.dart'; // Asegúrate de que la ruta sea correcta
import '../features/qr_code/data/models/qr_code_model.dart'; // Asegúrate de que la ruta sea correcta
import '../features/qr_code/presentation/widgets/qr_code_widget.dart';
import '../models/business_card_model.dart';

class BusinessCardCreateStepFourScreen extends StatefulWidget {
  const BusinessCardCreateStepFourScreen({super.key});

  @override
  State<BusinessCardCreateStepFourScreen> createState() =>
      _BusinessCardCreateStepFourScreenState();
}

class _BusinessCardCreateStepFourScreenState
    extends State<BusinessCardCreateStepFourScreen> {
  late final QrCodeModel cardQrCodeStepOne;
  late final BusinessCardModel businessCard;
  bool _layoutIsSelected = false;
  // late final BoxDecoration boxDecorationStepTwo;
  late final String mainText;
  late final String secondaryText;

  // Nuevas variables para los parámetros del fondo
  late final bool _isGradient;
  late final int _color1Value;
  late final int? _color2Value;
  late final String? _selectedDirection;

  // Aquí guardaremos el BoxDecoration reconstruido para la UI
  BoxDecoration? boxDecorationStepTwo;

  // Mapas de alineación (cópiarlos desde BusinessCardCreateStepTwoScreen)
  final Map<String, Alignment> _beginAlignments = {
    'leftToRight': Alignment.centerLeft,
    'rightToLeft': Alignment.centerRight,
    'topToBottom': Alignment.topCenter,
    'bottomToTop': Alignment.bottomCenter,
    'centerOut': Alignment.center,
  };

  final Map<String, Alignment> _endAlignments = {
    'leftToRight': Alignment.centerRight,
    'rightToLeft': Alignment.centerLeft,
    'topToBottom': Alignment.bottomCenter,
    'bottomToTop': Alignment.topCenter,
    'centerOut': Alignment.center,
  };

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    cardQrCodeStepOne = QrCodeModel.fromJson(arguments['cardQrCodeStepOne']);
    // boxDecorationStepTwo = arguments['decorationStepTwo'];
    mainText = arguments['mainText'];
    secondaryText = arguments['secondaryText'];

    // Recibe los parámetros del fondo de la pantalla anterior
    _isGradient = arguments['isGradient'];
    _color1Value = arguments['color1Value'];
    _color2Value = arguments['color2Value'];
    _selectedDirection = arguments['selectedDirection'];

    // Reconstruye el BoxDecoration usando los parámetros recibidos
    _buildDecorationFromRawParams();

    print(
        'QR Code Data: ${cardQrCodeStepOne.data}'); // Acceder a un campo como 'data' o 'value'
    print('Main Text received: $mainText');
    print('Secondary Text received: $secondaryText');
    print(
        'Background params: isGradient=$_isGradient, color1Value=$_color1Value, color2Value=$_color2Value, direction=$_selectedDirection');
  }

  // Método para reconstruir el BoxDecoration
  void _buildDecorationFromRawParams() {
    final Color color1 = Color(_color1Value);
    final Color? color2 = _color2Value != null ? Color(_color2Value) : null;

    if (_isGradient && _selectedDirection == 'centerOut' && color2 != null) {
      boxDecorationStepTwo = BoxDecoration(
        gradient: RadialGradient(
          colors: [color1, color2],
          center: Alignment.center,
          radius: 1.0,
        ),
      );
    } else if (_isGradient && color2 != null) {
      boxDecorationStepTwo = BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: _beginAlignments[_selectedDirection!]!,
          end: _endAlignments[_selectedDirection]!,
        ),
      );
    } else {
      boxDecorationStepTwo = BoxDecoration(color: color1);
    }
  }

  void _selectLayoutAndProceed(int layoutIndex) {
    // Aquí puedes guardar la selección del layout o pasarla al siguiente paso
    print('Layout seleccionado: $layoutIndex');

    // 1. Crea una instancia de BusinessCardModel con todos los datos
    businessCard = BusinessCardModel(
      businessCardId: StringUtil.nanoId(),
      qrCodeId: cardQrCodeStepOne
          .id, // Asegúrate que 'id' del QrCodeModel no sea nulo
      mainText: mainText,
      secondaryText: secondaryText.isNotEmpty
          ? secondaryText
          : null, // Guarda como null si está vacío
      layoutType: layoutIndex,
      isGradient: _isGradient,
      color1Value: _color1Value,
      color2Value: _color2Value,
      gradientDirection: _selectedDirection,
    );
    setState(() {
      _layoutIsSelected = true;
    });
    Get.snackbar(
      'Layout Seleccionado',
      'Has elegido el Layout $layoutIndex. ¡Listo para la vista final!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blueAccent,
      colorText: Colors.white,
    );
  }

  // Widget para el placeholder del QR Code
  Widget _buildQrCodePlaceholder() {
    return Container(
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: QrCodeWidget(
          qrCodeModel: cardQrCodeStepOne,
          backgroundPadding: 7,
        ),
      ),
    );
  }

  // --- Layouts de la Tarjeta ---

  Widget _buildCardLayout1(BuildContext context) {
    // Clásico y Minimalista: Texto principal grande arriba, secundario debajo, QR en la esquina.
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 320, // Ancho de la tarjeta
        height: 182, // Alto de la tarjeta (aprox. proporción 1.75:1)
        decoration: boxDecorationStepTwo, // El fondo dinámico
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Color de texto sugerido para contraste con fondo
                  shadows: const [
                    Shadow(
                        blurRadius: 3,
                        color: Colors.black54,
                        offset: Offset(1, 1))
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                secondaryText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  shadows: const [
                    Shadow(
                        blurRadius: 3,
                        color: Colors.black54,
                        offset: Offset(1, 1))
                  ],
                ),
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

  Widget _buildCardLayout2(BuildContext context) {
    // Moderno y Dinámico (Mi favorito): Texto principal centrado, secundario debajo, QR a un lado.
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 320,
        height: 180,
        decoration: boxDecorationStepTwo,
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
                      mainText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900, // Más grueso
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                              blurRadius: 4,
                              color: Colors.black87,
                              offset: Offset(1, 1))
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text(
                      secondaryText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                              blurRadius: 3,
                              color: Colors.black54,
                              offset: Offset(1, 1))
                        ],
                      ),
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

  Widget _buildCardLayout3(BuildContext context) {
    // Estructurado con Franja: Una línea divisoria o un color de fondo diferente para el QR.
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 320,
        height: 180,
        decoration: boxDecorationStepTwo,
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
                      mainText,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                              blurRadius: 3,
                              color: Colors.black54,
                              offset: Offset(1, 1))
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      secondaryText,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        shadows: const [
                          Shadow(
                              blurRadius: 3,
                              color: Colors.black54,
                              offset: Offset(1, 1))
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Franja de separación o área de QR
            Container(
              width: 2, // Línea sutil de separación
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

  Widget _buildCardLayout4(BuildContext context) {
    // Creativo y Asimétrico: QR grande en el centro, texto principal arriba y secundario abajo.
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 320,
        height: 180,
        decoration: boxDecorationStepTwo,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Espacio entre elementos
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  mainText,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                          blurRadius: 3,
                          color: Colors.black54,
                          offset: Offset(1, 1))
                    ],
                  ),
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
                  secondaryText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    shadows: const [
                      Shadow(
                          blurRadius: 3,
                          color: Colors.black54,
                          offset: Offset(1, 1))
                    ],
                  ),
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

  void _submit() async {
    // Validar el formulario antes de procesar
    if (!_layoutIsSelected) {
      Get.snackbar(
        'Oops!',
        'Por favor, selecciona un layout de presentación.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      try {
        final BusinessCardDatabaseHelper dbHelper =
            BusinessCardDatabaseHelper();
        final int result = await dbHelper.saveBusinessCard(
            businessCard); // Usa 'save' para insertar o actualizar

        if (result > 0) {
          final String layoutType = businessCard.layoutType.toString();
          Get.snackbar(
            '¡Éxito!',
            'Tarjeta de presentación guardada con el Layout $layoutType.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Opcional: Navegar a una pantalla de vista final o al inicio
          Get.toNamed(nameCreateBusinessCardSuccess);
        } else {
          Get.snackbar(
            'Error',
            'No se pudo guardar la tarjeta de presentación.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error de Base de Datos',
          'Ocurrió un error al guardar la tarjeta: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '4. Elige tu Diseño',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Selecciona uno de los siguientes diseños para tu tarjeta de presentación. Puedes ver cómo se verán tus textos y código QR.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Layout 1
            Text('Layout 1: Clásico y Minimalista',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            _buildCardLayout1(context),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLayoutAndProceed(1),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: Text('Seleccionar Layout 1'),
            ),
            SizedBox(height: 40),

            // Layout 2 (Mi favorito)
            Text('Layout 2: Moderno y Dinámico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            _buildCardLayout2(context),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLayoutAndProceed(2),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).colorScheme.primary, // Color principal
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: Text('Seleccionar Layout 2'),
            ),
            SizedBox(height: 40),

            // Layout 3
            Text('Layout 3: Estructurado con Franja',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            _buildCardLayout3(context),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLayoutAndProceed(3),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: Text('Seleccionar Layout 3'),
            ),
            SizedBox(height: 40),

            // Layout 4
            Text('Layout 4: Creativo y Asimétrico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            _buildCardLayout4(context),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectLayoutAndProceed(4),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              ),
              child: Text('Seleccionar Layout 4'),
            ),
            SizedBox(height: 30), // Espacio al final
          ],
        ),
      ),
      // Podrías tener un botón "Continuar" general en el bottom bar
      // que tome la selección actual del usuario, si los layouts fueran seleccionables
      // con un radio button o similar. Para esta implementación, cada layout tiene su propio botón.
      bottomNavigationBar: Visibility(
        visible:
            true, // Ocultar el BottomBarWidget si cada layout tiene su propio botón
        child: BottomBarWidget(
          labelBtn: 'Guardar',
          function: _submit,
        ),
      ),
    );
  }
}
