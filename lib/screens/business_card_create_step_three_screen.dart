// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/routes/routes_names.dart';
import '../core/widgets/bottom_bar_widget.dart';
import '../features/qr_code/data/models/qr_code_model.dart';

class BusinessCardCreateStepThreeScreen extends StatefulWidget {
  const BusinessCardCreateStepThreeScreen({super.key});

  @override
  State<BusinessCardCreateStepThreeScreen> createState() =>
      _BusinessCardCreateStepThreeScreenState();
}

class _BusinessCardCreateStepThreeScreenState
    extends State<BusinessCardCreateStepThreeScreen> {
  // Clave global para el formulario, necesaria para la validación
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final QrCodeModel cardQrCodeStepOne;
  // late final BoxDecoration boxDecorationStepTwo;
  late final bool isGradientFromStepTwo;
  late final int color1ValueFromStepTwo;
  late final int? color2ValueFromStepTwo;
  late final String? selectedDirectionFromStepTwo;
  final TextEditingController _mainTextController = TextEditingController();
  final TextEditingController _secondaryTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    cardQrCodeStepOne = QrCodeModel.fromJson(arguments['cardQrCodeStepOne']);
    // boxDecorationStepTwo = arguments['decorationStepTwo'];

    // Recibe los nuevos parámetros del fondo
    isGradientFromStepTwo = arguments['isGradient'];
    color1ValueFromStepTwo = arguments['color1Value'];
    color2ValueFromStepTwo = arguments['color2Value'];
    selectedDirectionFromStepTwo = arguments['selectedDirection'];

    print('id qr');
    print(cardQrCodeStepOne.id);
    print('boxdecoration');
    // print(boxDecorationStepTwo);
  }

  @override
  void dispose() {
    _mainTextController.dispose();
    _secondaryTextController.dispose();
    super.dispose();
  }

  void _submit() {
    // Validar el formulario antes de procesar
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!
          .save(); // Opcional, guarda los campos si usas onSaved

      final mainText = _mainTextController.text.trim();
      final secondaryText = _secondaryTextController.text.trim();

      print('Main Text: $mainText');
      print('Secondary Text: $secondaryText');

      // Aquí podrías navegar a la siguiente pantalla o procesar los datos
      Get.toNamed(nameCreateBusinessCardStepFour, arguments: <String, dynamic>{
        'cardQrCodeStepOne': cardQrCodeStepOne.toJson(),
        // 'decorationStepTwo': boxDecorationStepTwo,
        'isGradient': isGradientFromStepTwo,
        'color1Value': color1ValueFromStepTwo,
        'color2Value': color2ValueFromStepTwo,
        'selectedDirection': selectedDirectionFromStepTwo,
        'mainText': mainText,
        'secondaryText': secondaryText,
      });

      // Ejemplo de snackbar para confirmar el envío
      // Get.snackbar(
      //   '¡Éxito!',
      //   'Texto guardado correctamente para la vista previa.',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } else {
      // Si la validación falla, mostrar un mensaje al usuario
      Get.snackbar(
        'Error de validación',
        'Por favor, corrige los errores en el formulario.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '3. Personaliza tu Información',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Permite el scroll si el contenido excede la pantalla
        padding: const EdgeInsets.all(
            20), // Aumentamos el padding para mejor espaciado
        child: Form(
          key: _formKey, // Asignamos la clave del formulario
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinea los elementos a la izquierda
            children: [
              Text(
                'Introduce el texto que aparecerá en tu tarjeta. Esto ayudará a los demás a identificarte.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30), // Espaciado mayor
              Text(
                'Texto Principal (Obligatorio)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _mainTextController,
                minLines: 3,
                maxLines: 5, // Aumentamos un poco el maxLines
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Ej: Nombre, Título, Empresa...',
                  hintText: 'Tu información más importante',
                  alignLabelWithHint:
                      true, // Alinea el label con el hint si hay minLines
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Bordes más redondeados
                    borderSide: BorderSide
                        .none, // Quitamos el borde por defecto si usamos filled
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Fondo más claro
                  prefixIcon: Icon(Icons.person), // Icono decorativo
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 13), // Estilo para el texto de error
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El texto principal no puede estar vacío.';
                  }
                  if (value.trim().length < 5) {
                    return 'El texto principal debe tener al menos 5 caracteres.';
                  }
                  return null; // Retorna null si la validación es exitosa
                },
              ),
              SizedBox(height: 25), // Espaciado entre campos
              Text(
                'Texto Secundario (Opcional)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _secondaryTextController,
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Ej: Contacto, Redes Sociales, Descripción...',
                  hintText: 'Información adicional o complementaria',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  prefixIcon: Icon(Icons.info_outline), // Otro icono decorativo
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  errorStyle: TextStyle(color: Colors.red, fontSize: 13),
                ),
                // Para este campo, la validación es opcional (no es requerido)
                // Pero podrías añadir reglas como longitud mínima si lo deseas, incluso si es opcional.
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      value.trim().length < 5) {
                    return 'El texto secundario debe tener al menos 5 caracteres si se introduce.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              // Puedes añadir más elementos aquí, como un preview de la tarjeta si es posible
              Center(
                child: Text(
                  '¡Casi listo! Presiona "Vista Previa" para ver cómo queda tu tarjeta.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      // BottomNavigationBar con el botón de siguiente
      bottomNavigationBar: Visibility(
        visible: true, // Asegura que siempre sea visible
        child: BottomBarWidget(
          labelBtn: 'Vista Previa',
          function: _submit,
        ),
      ),
    );
  }
}
