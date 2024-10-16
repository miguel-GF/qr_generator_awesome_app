import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../features/qr_code/data/data_sources/local/qr_code_database_helper.dart';
import '../core/widgets/bottom_bar_widget.dart';
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
  late final QrCodeModel qrCodeStepOne;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;
    qrCodeStepOne = QrCodeModel.fromJson(arguments['qrCodeStepOne']);
  }

  Future<void> saveQrCode() async {
    try {
      QrCodeModel newQrCode = QrCodeModel(
        id: qrCodeStepOne.id,
        type: qrCodeStepOne.type,
        data: qrCodeStepOne.data,
        backgroundColor: _backgroundColor,
        eyeColor: _eyeColor,
        pointColor: _qrColor,
        qrBackgroundColor: _qrBackgroundColor,
        text: qrCodeStepOne.text,
        comment: qrCodeStepOne.comment,
      );
      await QrCodeDatabaseHelper().insertQrCode(newQrCode);
    } catch (e) {
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2. Personalización de QR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
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
          SizedBox(
            width: Get.width * 0.5,
            child: Center(
              // Centrar el QR en su contenedor
              child: QrCodeWidget(
                qrCodeModel: QrCodeModel(
                  id: qrCodeStepOne.id,
                  type: qrCodeStepOne.type,
                  data: qrCodeStepOne.data,
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
          Expanded(
            child: _buildOptionsGrid(),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarWidget(
        labelBtn: 'Guardar',
        function: () async => saveQrCode(),
      ),
    );
  }

  // Widget que genera el menú de opciones con un GridView
  Widget _buildOptionsGrid() {
    return GridView.count(
      crossAxisCount: 2, // Dos columnas
      crossAxisSpacing: 20,
      mainAxisSpacing: 8,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        _buildOption(
          icon: Icons.format_color_fill,
          label: 'Color de fondo',
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
          icon: Icons.format_color_fill,
          label: 'Color de fondo QR',
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
    );
  }

  // Widget para cada opción del menú
  Widget _buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
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
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: onColorSelected,
              availableColors: const [
                Colors.transparent,
                Colors.red,
                Colors.purple,
                Colors.orange,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.pink,
                Colors.teal,
                Colors.cyan,
                Colors.amber,
                Colors.lime,
                Colors.brown,
                Colors.grey,
                Colors.black,
                Colors.white,
              ],
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
