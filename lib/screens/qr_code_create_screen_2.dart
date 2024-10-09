// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/qr_code/data/models/qr_code_model.dart';
import '../features/qr_code/presentation/widgets/qr_code_widget.dart';

class QrCodeCreateScreen extends StatefulWidget {
  const QrCodeCreateScreen({super.key});

  @override
  State<QrCodeCreateScreen> createState() => _QrCodeCreateScreenState();
}

class _QrCodeCreateScreenState extends State<QrCodeCreateScreen> {
  double _padding = 16.0; // Padding inicial
  double _sizeFactor = 2.0; // Tamaño del QR (1.0 = tamaño máximo)
  String _type = 'texto'; // Tipo por defecto
  String _data = ''; // Datos del QR

  // Datos del contacto
  String _contactName = '';
  String _contactEmail = '';
  String _contactPhone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de QR'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Slider para ajustar el padding
              Text('Padding: ${_padding.toStringAsFixed(0)}'),
              Slider(
                max: 50,
                value: _padding,
                onChanged: (value) {
                  setState(() {
                    _padding = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Slider para ajustar el tamaño
              Text(
                  'Tamaño: ${((100 * (_sizeFactor - 1.5)) / (2.5 - 1.5)).toStringAsFixed(0)}%'), // Ajuste del valor mostrado
              Slider(
                min: 1.5, // Mínimo 150%
                max: 2.5, // Máximo 250%
                value: _sizeFactor,
                onChanged: (value) {
                  setState(() {
                    _sizeFactor = value;
                  });
                },
                label: (100 * _sizeFactor)
                    .toStringAsFixed(0), // Valor real para el Slider
              ),
              const SizedBox(height: 20),
              // Selección de tipo
              const Text('Tipo:'),
              DropdownButton<String>(
                value: _type,
                onChanged: (String? newValue) {
                  setState(() {
                    _type = newValue!;
                    // Limpiar datos al cambiar el tipo
                    _data = '';
                    _contactName = '';
                    _contactEmail = '';
                    _contactPhone = '';
                  });
                },
                items: <String>['texto', 'link', 'contacto']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Input según el tipo
              _buildInputFields(),
              const SizedBox(height: 20),
              // Botón para generar el código QR
              ElevatedButton(
                onPressed: () {
                  // Generar el QR (esto debería ser un método para construir el modelo)
                  _generateQRCode();
                },
                child: const Text('Generar QR'),
              ),
              const SizedBox(height: 20),
              // Muestra el widget QR
              SizedBox(
                width: double.infinity, // Se ajusta al ancho disponible
                height:
                    Get.height * 0.4, // Ajustar la altura según sea necesario
                child: Center(
                  child: SizedBox(
                    width: 100 * _sizeFactor, // Ajusta el ancho
                    height: 100 * _sizeFactor, // Ajusta la altura
                    child: QrCodeWidget(
                      qrCodeModel: QrCodeModel(
                        id: 'wdafW',
                        type: _type,
                        data: _data,
                        size: 100 * _sizeFactor, // Tamaño del QR
                        padding: _padding,
                        backgroundColor: Colors.white,
                        eyeColor: Colors.black,
                        pointColor: Colors.black,
                        qrBackgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    switch (_type) {
      case 'texto':
      case 'link':
        return TextField(
          decoration: InputDecoration(
            labelText: _type == 'texto' ? 'Texto' : 'Link',
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            setState(() {
              _data = value;
            });
          },
        );
      case 'contacto':
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _contactName = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _contactEmail = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _contactPhone = value;
                });
              },
            ),
          ],
        );
      default:
        return Container(); // O algún otro manejo
    }
  }

  void _generateQRCode() {
    // Aquí podrías construir tu modelo QrCodeModel si es necesario
    // Por ahora, solo se muestra en el widget
    if (_type == 'contacto') {
      // Generar el formato de contacto, por ejemplo:
      _data =
          'BEGIN:VCARD\nFN:$_contactName\nEMAIL:$_contactEmail\nTEL:$_contactPhone\nEND:VCARD';
    }
    // Actualizar el widget para mostrar el QR
    setState(() {});
  }
}
