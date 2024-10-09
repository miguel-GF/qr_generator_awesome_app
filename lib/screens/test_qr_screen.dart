import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../features/qr_code/presentation/widgets/qr_code_widget.dart';
import '../features/qr_code/data/models/qr_code_model.dart';

class QrCodeCreateStepTwoScreen extends StatefulWidget {
  const QrCodeCreateStepTwoScreen({super.key});

  @override
  State<QrCodeCreateStepTwoScreen> createState() =>
      _QrCodeCreateStepTwoScreenState();
}

class _QrCodeCreateStepTwoScreenState extends State<QrCodeCreateStepTwoScreen> {
  // Valores iniciales para la personalización del QR
  Color _backgroundColor = Colors.white;
  Color _qrColor = Colors.black;
  Color _eyeColor = Colors.black;
  Color _qrBackgroundColor = Colors.transparent;
  String _eyeShape = 'square'; // Valores: 'round' o 'square'
  String _pointShape = 'square'; // Valores: 'round' o 'square'
  double _padding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generador de QR - Personalización'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Control deslizante para el padding
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

          // Vista Previa del QR
          Container(
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width * 0.6, // 60% del ancho
            padding: const EdgeInsets.all(16.0),
            child: Center( // Centrar el QR en su contenedor
              child: QrCodeWidget(
                qrCodeModel: QrCodeModel(
                  id: 'QR123',
                  type: 'texto', // Solo para mantener la estructura
                  data: 'https://ejemplo.com', // Un QR genérico por ahora
                  size: 200, // Ajuste fijo del tamaño
                  padding: _padding,
                  backgroundColor: _backgroundColor,
                  pointColor: _qrColor,
                  eyeColor: _eyeColor,
                  eyeType: _eyeShape, // Forma de los ojos
                  pointType: _pointShape,
                  qrBackgroundColor: _qrBackgroundColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Menú de Opciones (Lado izquierdo o derecho)
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildOption(
                    icon: Icons.format_color_fill,
                    label: 'Color de Fondo',
                    onTap: () => _showColorPicker(
                      currentColor: _backgroundColor,
                      onColorSelected: (color) {
                        setState(() {
                          _backgroundColor = color;
                        });
                      },
                    ),
                  ),
                  _buildOption(
                    icon: Icons.qr_code,
                    label: 'Color del QR',
                    onTap: () => _showColorPicker(
                      currentColor: _qrColor,
                      onColorSelected: (color) {
                        setState(() {
                          _qrColor = color;
                        });
                      },
                    ),
                  ),
                  _buildOption(
                    icon: Icons.remove_red_eye,
                    label: 'Color de los Ojos',
                    onTap: () => _showColorPicker(
                      currentColor: _eyeColor,
                      onColorSelected: (color) {
                        setState(() {
                          _eyeColor = color;
                        });
                      },
                    ),
                  ),
                  _buildOption(
                    icon: Icons.remove_red_eye,
                    label: 'Color de Fondo',
                    onTap: () => _showColorPicker(
                      currentColor: _qrBackgroundColor,
                      onColorSelected: (color) {
                        setState(() {
                          _qrBackgroundColor = color;
                        });
                      },
                    ),
                  ),
                  _buildOption(
                    icon: Icons.crop_square,
                    label: 'Forma de los Ojos',
                    onTap: () => _showEyeShapeSelector(),
                  ),
                  _buildOption(
                    icon: Icons.crop_square,
                    label: 'Forma de los Puntos',
                    onTap: () => _showPointShapeSelector(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Lógica para guardar el QR personalizado
          },
          child: const Text('Guardar'),
        ),
      ),
    );
  }

  // Widget que genera el menú de opciones con scroll
  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(label),
      onTap: onTap,
    );
  }

  // Modal para seleccionar color
  void _showColorPicker({
    required Color currentColor,
    required Function(Color) onColorSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona un color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorSelected,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Modal para seleccionar la forma de los ojos
  void _showEyeShapeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona la forma de los ojos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.circle_outlined),
                title: const Text('Redondo'),
                onTap: () {
                  setState(() {
                    _eyeShape = 'round';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.crop_square),
                title: const Text('Cuadrado'),
                onTap: () {
                  setState(() {
                    _eyeShape = 'square';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Modal para seleccionar la forma de los puntos
  void _showPointShapeSelector() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona la forma de los puntos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.circle_outlined),
                title: const Text('Redondo'),
                onTap: () {
                  setState(() {
                    _pointShape = 'round';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.crop_square),
                title: const Text('Cuadrado'),
                onTap: () {
                  setState(() {
                    _pointShape = 'square';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
