import 'package:mockito/annotations.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/repositories/qr_code_repository.dart';

@GenerateMocks(
  [
    QrCodeRepository,
  ],
  // customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
