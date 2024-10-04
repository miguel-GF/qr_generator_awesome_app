// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_awesome_generator/features/qr_code/presentation/widgets/input_add_new_data.dart';

import '../features/qr_code/data/models/qr_code_model.dart'; // Librería para íconos sociales

class QrCodeCreateStepOneScreen extends StatefulWidget {
  const QrCodeCreateStepOneScreen({super.key});

  @override
  State<QrCodeCreateStepOneScreen> createState() =>
      _QrCodeCreateStepOneScreenState();
}

class _QrCodeCreateStepOneScreenState extends State<QrCodeCreateStepOneScreen> {
  String _selectedType = 'texto'; // Tipo seleccionado por defecto
  // Key
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController _textGlobalCtr = TextEditingController();
  final TextEditingController _telefonoCtr = TextEditingController();
  final TextEditingController _whatsappCtr = TextEditingController();
  final TextEditingController _descripcionCtr = TextEditingController();

  @override
  void dispose() {
    _textGlobalCtr.dispose();
    _telefonoCtr.dispose();
    _whatsappCtr.dispose();
    _descripcionCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona el tipo de código'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Seleccione el tipo de código que desea generar:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Slider de tipos de código QR (Horizontal)
          SizedBox(
            height: Get.height * 0.2, // Altura proporcional
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Número de columnas
                mainAxisSpacing: 20.0, // Espacio vertical entre los elementos
                crossAxisSpacing:
                    30.0, // Espacio horizontal entre los elementos
              ),
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: [
                _buildCodeTypeButton('texto', FontAwesomeIcons.textWidth),
                _buildCodeTypeButton('link', FontAwesomeIcons.link),
                _buildCodeTypeButton('contacto', FontAwesomeIcons.addressBook),
                _buildCodeTypeButton('whatsapp', FontAwesomeIcons.whatsapp),
                _buildCodeTypeButton('facebook', FontAwesomeIcons.facebook),
              ],
              // child: ListView(
              //   scrollDirection: Axis.horizontal,
              //   physics: const AlwaysScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   children: [
              //     _buildCodeTypeButton('texto', FontAwesomeIcons.textWidth),
              //     _buildCodeTypeButton('link', FontAwesomeIcons.link),
              //     _buildCodeTypeButton('contacto', FontAwesomeIcons.addressBook),
              //     _buildCodeTypeButton('whatsapp', FontAwesomeIcons.whatsapp),
              //     _buildCodeTypeButton('facebook', FontAwesomeIcons.facebook),
              //   ],
              // ),
            ),
          ),
          const SizedBox(height: 20),
          // Inputs con Scroll en caso de ser necesario
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: _buildInputFields(),
                ),
              ),
            ),
          ),
        ],
      ),
      // BottomNavigationBar con el botón de siguiente
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: TextButton(
            onPressed: () {
              // Usar la GlobalKey para validar el formulario
              if (_formKey.currentState!.validate()) {
                // Si es válido, ejecutar alguna acción (ej. enviar datos)
                String qrData = '';

                switch (_selectedType) {
                  case 'texto':
                  case 'link':
                  case 'facebook':
                    qrData = _textGlobalCtr.text;
                    break;
                  case 'contacto':
                    qrData = 'BEGIN:VCARD\n'
                        'VERSION:3.0\n'
                        'FN:${_textGlobalCtr.text}\n'
                        'TEL:${_telefonoCtr.text}\n'
                        'END:VCARD';
                    break;
                  case 'whatsapp':
                    qrData = 'https://wa.me/${_whatsappCtr.text}?text=Hola';
                    break;
                }
                final QrCodeModel qrCodeModel = QrCodeModel(
                  id: 'tes1',
                  data: qrData,
                  type: _selectedType,
                  description: _descripcionCtr.text,
                  backgroundColor: Colors.transparent,
                  eyeColor: Colors.black,
                  pointColor: Colors.black,
                );
                print(qrCodeModel);
              } else {
                // Si no es válido, mostrar un mensaje
                Get.snackbar(
                    'Datos incompletos o incorrectos', 'Formulario no válido',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: const Text('SIGUIENTE'),
          ),
        ),
      ),
    );
  }

  // Construir los botones de selección del tipo de QR
  Widget _buildCodeTypeButton(String type, IconData icon) {
    bool isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: Get.width * 0.25, // Ancho proporcional
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: 30,
              color: isSelected ? Colors.white : Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              type.capitalizeFirst!,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Inputs según el tipo seleccionado
  List<Widget> _buildInputFields() {
    List<Widget> fields = [];
    switch (_selectedType) {
      case 'texto':
        fields.add(
          InputAddNewData(
            controller: _textGlobalCtr,
            labelText: 'Texto',
            hintText: 'Ingrese el texto para el código QR',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
        );
        break;
      case 'link':
        fields.add(
          InputAddNewData(
            controller: _textGlobalCtr,
            labelText: 'Link',
            maxLength: 150,
            hintText: 'Ingrese la URL para el código QR',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
        );
        break;
      case 'contacto':
        fields.addAll([
          InputAddNewData(
            controller: _textGlobalCtr,
            labelText: 'Nombre de contacto',
            hintText: 'Ingrese el nombre de contacto',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
          InputAddNewData(
            controller: _telefonoCtr,
            labelText: 'Teléfono de contacto',
            maxLength: 15,
            hintText: 'Ingrese el número de teléfono del contacto',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
        ]);
        break;
      case 'whatsapp':
        fields.add(InputAddNewData(
          controller: _whatsappCtr,
          maxLength: 15,
          labelText: 'Número de whatsapp',
          hintText: 'Ingrese el número de whatsapp',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Es requerido';
            }
            return null;
          },
        ));
        break;
      case 'facebook':
        fields.add(InputAddNewData(
          controller: _textGlobalCtr,
          maxLength: 80,
          labelText: 'URL de facebook',
          hintText: 'Ingrese el enlace al perfil de facebook',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Es requerido';
            }
            return null;
          },
        ));
        break;
    }
    fields.add(InputAddNewData(
      controller: _descripcionCtr,
      maxLines: 3,
      maxLength: 250,
      labelText: 'Descripción del Código',
      hintText: 'Descripción para identificar el qr con facilidad',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Es requerido';
        }
        return null;
      },
    ));

    return fields;
  }
}
