import 'package:dartz/dartz.dart';
import 'package:qr_awesome_generator/core/error/failure.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/entities/qr_code_entity.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/repositories/qr_code_repository.dart';

class GetCurrentQrCodeUseCase {
  final QrCodeRepository qrCodeRepository;
  GetCurrentQrCodeUseCase(this.qrCodeRepository);
  Future<Either<Failure, QrCodeEntity>> call(String id) async {
    return qrCodeRepository.getCurrentQrCode(id);
  }
}
