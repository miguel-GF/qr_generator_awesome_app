import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/entities/qr_code_entity.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/use_cases/get_current_qr_code_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentQrCodeUseCase getCurrentQrCodeUseCase;
  late MockQrCodeRepository mockQrCodeRepository;

  setUp(() {
    mockQrCodeRepository = MockQrCodeRepository();
    getCurrentQrCodeUseCase = GetCurrentQrCodeUseCase(mockQrCodeRepository);
  });

  var testQrCode = QrCodeEntity(id: '#1', type: 'text', data: 'data');
  const testId = '#1';

  test('should get current qr code from the repository', () async {
    //arrange
    when(mockQrCodeRepository.getCurrentQrCode(testId))
        .thenAnswer((_) async => Right(testQrCode));
    //act
    final result = await getCurrentQrCodeUseCase(testId);
    //assert
    expect(result, Right(testQrCode));
    verify(mockQrCodeRepository.getCurrentQrCode(testId));
    verifyNoMoreInteractions(mockQrCodeRepository);
  });
}
