// Puedes añadir esta clase en el mismo archivo HomeCardsWidget.dart

import '../../../../models/business_card_model.dart';
import '../../../qr_code/data/models/qr_code_model.dart';

class FullBusinessCardDisplayData {
  final BusinessCardModel businessCard;
  final QrCodeModel qrCode;

  FullBusinessCardDisplayData(
      {required this.businessCard, required this.qrCode});
}
