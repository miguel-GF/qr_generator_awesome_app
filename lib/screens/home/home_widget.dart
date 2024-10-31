import 'package:flutter/material.dart';
import '../../core/widgets/main_title_widget.dart';
import '../../features/qr_code/data/data_sources/local/qr_code_database_helper.dart';
import '../../features/qr_code/data/models/qr_code_model.dart';
import '../../features/qr_code/presentation/widgets/qr_code_item_list_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  // Método que devuelve el Future de la lista de códigos QR
  Future<List<QrCodeModel>> _getQrCodes() async {
    return await QrCodeDatabaseHelper().getQrCodes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QrCodeModel>>(
      future: _getQrCodes(), // Future que queremos esperar
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un indicador de carga mientras el Future se resuelve
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Muestra un mensaje si hay un error en el Future
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Muestra la lista de códigos QR cuando el Future se completa
            final qrCodes = snapshot.data!;
            return Column(
              children: [
                const MainTitleWidget(
                  title: 'Códigos QR que has generado',
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: qrCodes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Número de columnas
                    crossAxisSpacing: 16, // Espacio horizontal entre columnas
                    mainAxisSpacing: 16, // Espacio vertical entre filas
                    childAspectRatio: 1/1.7,
                  ),
                  itemBuilder: (context, index) {
                    return QrCodeItemListWidget(
                      key: ObjectKey(qrCodes[index]),
                      qrCode: qrCodes[index],
                    );
                  },
                )
              ],
            );
          } else {
            // Muestra un mensaje si la lista de datos está vacía
            return const Center(
              child: Text('No hay códigos QR disponibles.'),
            );
          }
        } else {
          // Por si acaso el estado no es ninguno de los esperados
          return const Center(
            child: Text('Estado inesperado'),
          );
        }
      },
    );
  }
}
