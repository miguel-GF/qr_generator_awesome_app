import 'package:flutter/material.dart';
import 'package:qr_awesome_generator/core/database/local/business_card_database_helper.dart';
import 'package:qr_awesome_generator/models/business_card_model.dart';
import '../../core/widgets/main_title_widget.dart';
import 'package:qr_awesome_generator/features/business_card/presentation/widgets/business_card_display_widget.dart';

import 'package:qr_awesome_generator/features/business_card/data/models/full_busines_card_display_data.dart';
import 'package:qr_awesome_generator/features/qr_code/data/data_sources/local/qr_code_database_helper.dart';

class HomeCardsWidget extends StatefulWidget {
  const HomeCardsWidget({super.key});

  @override
  State<HomeCardsWidget> createState() => _HomeCardsWidgetState();
}

class _HomeCardsWidgetState extends State<HomeCardsWidget> {
  late Future<List<FullBusinessCardDisplayData>> _cardsToDisplay;

  @override
  void initState() {
    super.initState();
    _cardsToDisplay = _loadBusinessCardsWithQRs();
  }

  Future<List<FullBusinessCardDisplayData>> _loadBusinessCardsWithQRs() async {
    final businessCardHelper = BusinessCardDatabaseHelper();
    final qrCodeHelper =
        QrCodeDatabaseHelper(); // Instancia de tu helper de QR Codes

    final businessCards = await businessCardHelper.getBusinessCards();
    final List<FullBusinessCardDisplayData> fullCards = [];

    for (final bc in businessCards) {
      final qrCode = await qrCodeHelper.getQrCodeById(bc.qrCodeId);

      if (qrCode != null) {
        fullCards
            .add(FullBusinessCardDisplayData(businessCard: bc, qrCode: qrCode));
      } else {
        print(
            'Advertencia: QR Code con ID ${bc.qrCodeId} no encontrado.');
      }
    }
    return fullCards;
  }

  Future<void> _onFavorite(BusinessCardModel businessCard) async {
    // Cambia el valor de favorite a su inverso
    final newFavoriteValue = businessCard.favorite == 'no' ? 'si' : 'no';

    try {
      // Actualiza el valor en la base de datos con el valor correcto
      final res = await BusinessCardDatabaseHelper()
          .updateFavorite(businessCard.businessCardId, newFavoriteValue);

      // Si la actualización fue exitosa, actualiza modelo local y la interfaz
      if (res == 1) {
        setState(() {
          businessCard.favorite =
              newFavoriteValue; // Actualiza el valor del modelo local
        });
      }
    } catch (e) {
      print('Error durante la actualización de favorito: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FullBusinessCardDisplayData>>(
      future: _cardsToDisplay,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final cards = snapshot.data!;
            return Column(
              children: [
                const MainTitleWidget(
                  title: 'Tarjetas de Presentación que has creado',
                ),
                // Aquí cambiamos de GridView.builder a ListView.builder
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: cards.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 24,
                    );
                  },
                  itemBuilder: (context, index) {
                    final fullCardData = cards[index];
                    return SizedBox(
                      child: BusinessCardDisplayWidget(
                        key: ValueKey(fullCardData.businessCard.businessCardId),
                        businessCard: fullCardData.businessCard,
                        qrCode: fullCardData.qrCode,
                        showVaforite: true,
                        onFavorite: () =>
                            _onFavorite(fullCardData.businessCard),
                      ),
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('No hay tarjetas de presentación disponibles.'),
            );
          }
        } else {
          return const Center(
            child: Text('Estado inesperado'),
          );
        }
      },
    );
  }
}
