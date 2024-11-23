import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '/core/constants/app_translations_keys/tab_favorite_translations_keys.dart';
import '../../core/widgets/main_title_widget.dart';
import '../../features/qr_code/data/data_sources/local/qr_code_database_helper.dart';
import '../../features/qr_code/data/models/qr_code_model.dart';
import '../../features/qr_code/presentation/widgets/qr_code_item_list_widget.dart';

class HomeFavoritesWidget extends StatefulWidget {
  const HomeFavoritesWidget({super.key});

  @override
  State<HomeFavoritesWidget> createState() => _HomeFavoritesWidgetState();
}

class _HomeFavoritesWidgetState extends State<HomeFavoritesWidget> {
  final TabFavoriteTranslationsKeys trKey = TabFavoriteTranslationsKeys();
  List<QrCodeModel> _qrCodesList = [];
  bool _isLoading = true; // Variable para controlar el estado de carga
  String? _errorMessage; // Variable para controlar errores

  @override
  void initState() {
    super.initState();
    _getQrCodes();
  }

  Future<void> _getQrCodes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final Map<String, dynamic> filters = {
        'favorite': 'si',
      };
      final qrCodes = await QrCodeDatabaseHelper().getQrCodes(filters: filters);

      setState(() {
        _qrCodesList = qrCodes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar los códigos QR: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _onFavorite(QrCodeModel qrCode) async {
    final newFavoriteValue = qrCode.favorite == 'no' ? 'si' : 'no';

    try {
      final res = await QrCodeDatabaseHelper()
          .updateFavorite(qrCode.id, newFavoriteValue);

      if (res == 1) {
        await _getQrCodes(); // Recarga la lista completa
      }
    } catch (e) {
      print('Error durante la actualización de favorito: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Muestra un indicador de carga mientras los datos se obtienen
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      // Muestra un mensaje de error si ocurrió un problema
      return Center(child: Text(_errorMessage!));
    }

    if (_qrCodesList.isEmpty) {
      // Muestra un mensaje si no hay códigos QR disponibles
      return const Center(
        child: Text('No hay códigos QR disponibles.'),
      );
    }

    // Muestra la lista de códigos QR
    return Column(
      children: [
        MainTitleWidget(
          title: trKey.title.tr,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _qrCodesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Número de columnas
            crossAxisSpacing: 16, // Espacio horizontal entre columnas
            mainAxisSpacing: 16, // Espacio vertical entre filas
            childAspectRatio: 1 / 1.7,
          ),
          itemBuilder: (context, index) {
            return QrCodeItemListWidget(
              key: ValueKey(_qrCodesList[index].id),
              qrCode: _qrCodesList[index],
              onFavorite: () => _onFavorite(_qrCodesList[index]),
            );
          },
        )
      ],
    );
  }
}
