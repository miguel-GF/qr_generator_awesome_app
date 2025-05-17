import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_awesome_generator/features/qr_code/presentation/widgets/qr_code_item_list_widget.dart';

import '../../features/qr_code/data/data_sources/local/qr_code_database_helper.dart';
import '../../features/qr_code/data/models/qr_code_model.dart';
import '../core/constants/app_translations_keys/card_create_step_one_traslations_keys.dart';
import '../core/routes/routes_names.dart';
import '../core/widgets/bottom_bar_widget.dart';
import '../core/widgets/main_title_widget.dart';

class BusinessCardCreateScreen extends StatefulWidget {
  const BusinessCardCreateScreen({super.key});

  @override
  State<BusinessCardCreateScreen> createState() =>
      _BusinessCardCreateScreenState();
}

class _BusinessCardCreateScreenState extends State<BusinessCardCreateScreen> {
  CardCreateStepOneTranslationsKeys trKey = CardCreateStepOneTranslationsKeys();
  QrCodeModel? selectedItem;
  late Future<List<QrCodeModel>> _qrCodesList;

  @override
  void initState() {
    super.initState();
    _qrCodesList = _getQrCodes();
  }

  // Método que devuelve el Future de la lista de códigos QR
  Future<List<QrCodeModel>> _getQrCodes() async {
    return await QrCodeDatabaseHelper().getQrCodes();
  }

  void _onSelected(QrCodeModel item) {
    setState(() {
      selectedItem = item;
    });
  }

  void goToNextStep() {
    if (selectedItem != null) {
      // Navega a la siguiente pantalla y pásale el objeto seleccionado
      Get.toNamed(nameCreateBusinessCardStepTwo, arguments: <String, dynamic>{
        'cardQrCodeStepOne': selectedItem!.toJson(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(trKey.title.tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: FutureBuilder<List<QrCodeModel>>(
            future: _qrCodesList, // Future que queremos esperar
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Muestra un indicador de carga mientras el Future resolve
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // Muestra un mensaje si hay un error en el Future
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  // Muestra la lista de códigos QR cuando el Future completa
                  final qrCodes = snapshot.data!;
                  return Column(
                    children: [
                      MainTitleWidget(
                        title: trKey.subtitle.tr,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: qrCodes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Número de columnas
                          crossAxisSpacing:
                              16, // Espacio horizontal entre columnas
                          mainAxisSpacing: 16, // Espacio vertical entre filas
                          childAspectRatio: 1 / 1.7,
                        ),
                        itemBuilder: (context, index) {
                          final qrCodeActual = qrCodes[index];
                          return QrCodeItemListWidget(
                            key: ValueKey(qrCodeActual.id),
                            qrCode: qrCodeActual,
                            onSelected: () => _onSelected(qrCodeActual),
                            showVaforite: false,
                            isSelected: selectedItem != null
                                ? selectedItem!.id == qrCodeActual.id
                                : false,
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
          ),
        ),
      ),
      // BottomNavigationBar con el botón de siguiente
      bottomNavigationBar: Visibility(
        visible: selectedItem != null,
        child: BottomBarWidget(
          labelBtn: trKey.btnAction.tr,
          function: () async => goToNextStep(),
        ),
      ),
    );
  }
}
