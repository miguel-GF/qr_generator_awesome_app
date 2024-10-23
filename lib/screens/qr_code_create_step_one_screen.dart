// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/core/constants/app_translations_keys/qr_code_create_step_one_translations_keys.dart';
import '/core/widgets/bottom_bar_widget.dart';
import '/core/routes/routes_names.dart';
import '/core/utils/string_util.dart';
import '/features/qr_code/presentation/widgets/input_add_new_data.dart';
import '/features/qr_code/data/models/qr_code_model.dart';

class QrCodeCreateStepOneScreen extends StatefulWidget {
  const QrCodeCreateStepOneScreen({super.key});

  @override
  State<QrCodeCreateStepOneScreen> createState() =>
      _QrCodeCreateStepOneScreenState();
}

class _QrCodeCreateStepOneScreenState extends State<QrCodeCreateStepOneScreen> {
  QrCodeCreateStepOneTranslationsKeys trKey =
      QrCodeCreateStepOneTranslationsKeys();
  String _selectedType = 'texto'; // Tipo seleccionado por defecto
  // Key
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController _textGlobalCtr = TextEditingController();
  final TextEditingController _telefonoCtr = TextEditingController();
  final TextEditingController _whatsappCtr = TextEditingController();
  final TextEditingController _commentCtr = TextEditingController();
  final TextEditingController _enterpriseCtr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();
  final TextEditingController _addressCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _countryCtr = TextEditingController();
  final TextEditingController _noteCtr = TextEditingController();
  final TextEditingController _urlCtr = TextEditingController();
  final TextEditingController _descriptionCtr = TextEditingController();

  @override
  void dispose() {
    _textGlobalCtr.dispose();
    _telefonoCtr.dispose();
    _whatsappCtr.dispose();
    _commentCtr.dispose();
    _enterpriseCtr.dispose();
    _emailCtr.dispose();
    _addressCtr.dispose();
    _cityCtr.dispose();
    _countryCtr.dispose();
    _noteCtr.dispose();
    _urlCtr.dispose();
    _descriptionCtr.dispose();
    super.dispose();
  }

  Future<void> _irPaginaDos(QrCodeModel qrCode) async {
    Get.toNamed(nameCreateQrCodeStepTwoScreen, arguments: <String, dynamic>{
      'qrCodeStepOne': qrCode.toJson(),
    });
  }

  void validateData() async {
    try {
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
            'BEGIN:VCARD\n'
                'VERSION:3.0\n' // Version de vCard
                'FN:${_textGlobalCtr.text}\n' // Nombre completo
                'ORG:${_enterpriseCtr.text}\n' // Empresa (Opcional)
                'TITLE:${_noteCtr.text}\n' // Cargo (Opcional, puedes usar description o note)
                'TEL:${_telefonoCtr.text}\n' // Teléfono principal
                'EMAIL:${_emailCtr.text}\n' // Correo electrónico
                'ADR;TYPE=HOME:${_addressCtr.text};${_cityCtr.text};${_countryCtr.text};\n' // Dirección
                'URL:${_urlCtr.text}\n' // Sitio web (Opcional)
                'NOTE:${_descriptionCtr.text}\n' // Nota o descripción del contacto (Opcional)
                'END:VCARD';
            break;
          case 'whatsapp':
            qrData = 'https://wa.me/${_whatsappCtr.text}?text=Hola';
            break;
        }
        late final QrCodeModel qrCodeModel;
        switch (_selectedType) {
          case 'texto':
            qrCodeModel = QrCodeModel(
              id: StringUtil.nanoId(),
              data: qrData,
              type: _selectedType,
              comment: _commentCtr.text,
              backgroundColor: Colors.white,
              eyeColor: Colors.black,
              pointColor: Colors.black,
              qrBackgroundColor: Colors.transparent,
              text: _textGlobalCtr.text,
            );
            break;
          case 'link':
            qrCodeModel = QrCodeModel(
              id: StringUtil.nanoId(),
              data: qrData,
              type: _selectedType,
              comment: _commentCtr.text,
              backgroundColor: Colors.white,
              eyeColor: Colors.black,
              pointColor: Colors.black,
              qrBackgroundColor: Colors.transparent,
              url: _textGlobalCtr.text,
            );
            break;
          case 'facebook':
            qrCodeModel = QrCodeModel(
              id: StringUtil.nanoId(),
              data: qrData,
              type: _selectedType,
              comment: _commentCtr.text,
              backgroundColor: Colors.white,
              eyeColor: Colors.black,
              pointColor: Colors.black,
              qrBackgroundColor: Colors.transparent,
              url: _textGlobalCtr.text,
            );
            break;
          case 'contacto':
            qrCodeModel = QrCodeModel(
              id: StringUtil.nanoId(),
              data: qrData,
              type: _selectedType,
              comment: _commentCtr.text,
              backgroundColor: Colors.white,
              eyeColor: Colors.black,
              pointColor: Colors.black,
              qrBackgroundColor: Colors.transparent,
              name: _textGlobalCtr.text,
              phone: _telefonoCtr.text,
              email: _emailCtr.text,
              url: _urlCtr.text,
              note: _noteCtr.text,
              address: _addressCtr.text,
              city: _cityCtr.text,
              country: _countryCtr.text,
              description: _descriptionCtr.text,
            );
            break;
          case 'whatsapp':
            qrCodeModel = QrCodeModel(
              id: StringUtil.nanoId(),
              data: qrData,
              type: _selectedType,
              comment: _commentCtr.text,
              backgroundColor: Colors.white,
              eyeColor: Colors.black,
              pointColor: Colors.black,
              qrBackgroundColor: Colors.transparent,
              name: _textGlobalCtr.text,
              phone: _whatsappCtr.text,
              message: 'Hola',
            );
            break;
        }
        await _irPaginaDos(qrCodeModel);
      } else {
        // Si no es válido, mostrar un mensaje
        Get.snackbar('Datos incompletos o incorrectos', 'Formulario no válido',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(trKey.title.tr),
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              trKey.instruction.tr,
              style: const TextStyle(fontSize: 16),
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
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildCodeTypeButton(
                    'texto',
                    FontAwesomeIcons.textWidth,
                    trKey.opcText,
                  ),
                  _buildCodeTypeButton(
                    'link',
                    FontAwesomeIcons.link,
                    trKey.opcLink,
                  ),
                  _buildCodeTypeButton(
                    'contacto',
                    FontAwesomeIcons.addressBook,
                    trKey.opcContact,
                  ),
                  _buildCodeTypeButton(
                    'whatsapp',
                    FontAwesomeIcons.whatsapp,
                    trKey.opcWhats,
                  ),
                  _buildCodeTypeButton(
                    'facebook',
                    FontAwesomeIcons.facebook,
                    trKey.opcFb,
                  ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
        bottomNavigationBar: BottomBarWidget(
          labelBtn: trKey.btnAction.tr,
          function: () async => validateData(),
        ));
  }

  // Construir los botones de selección del tipo de QR
  Widget _buildCodeTypeButton(String type, IconData icon, String label) {
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
              label.tr.capitalizeFirst!,
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
            labelText: trKey.labelText.tr,
            hintText: trKey.hintText.tr,
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
            labelText: trKey.labelLink.tr,
            maxLength: 150,
            hintText: trKey.hintLink.tr,
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
            labelText: trKey.labelContactName.tr,
            hintText: trKey.hintContactName.tr,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
          InputAddNewData(
            controller: _telefonoCtr,
            labelText: trKey.labelContactNumber.tr,
            maxLength: 15,
            hintText: trKey.hintContactNumber.tr,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Es requerido';
              }
              return null;
            },
          ),
          InputAddNewData(
            controller: _noteCtr,
            labelText: trKey.labelContactProfession.tr,
            maxLength: 15,
            hintText: trKey.hintContactProfession.tr,
          ),
          InputAddNewData(
            controller: _emailCtr,
            labelText: trKey.labelContactEmail.tr,
            maxLength: 15,
            hintText: trKey.hintContactEmail.tr,
          ),
          InputAddNewData(
            controller: _urlCtr,
            labelText: trKey.labelContactWeb.tr,
            maxLength: 15,
            hintText: trKey.hintContactWeb.tr,
          ),
          InputAddNewData(
            controller: _addressCtr,
            labelText: trKey.labelContactAddress.tr,
            maxLength: 15,
            hintText: trKey.hintContactAddress.tr,
          ),
          InputAddNewData(
            controller: _descriptionCtr,
            labelText: trKey.labelContactDescription.tr,
            maxLength: 15,
            hintText: trKey.hintContactDescription.tr,
          ),
        ]);
        break;
      case 'whatsapp':
        fields.add(InputAddNewData(
          controller: _whatsappCtr,
          maxLength: 15,
          labelText: trKey.labelWhats.tr,
          hintText: trKey.hintWhats.tr,
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
          labelText: trKey.labelFb.tr,
          hintText: trKey.hintFb.tr,
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
      controller: _commentCtr,
      maxLines: 3,
      maxLength: 250,
      labelText: trKey.labelComment.tr,
      hintText: trKey.hintComment.tr,
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
