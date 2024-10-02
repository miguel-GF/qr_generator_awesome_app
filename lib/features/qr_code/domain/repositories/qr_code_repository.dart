import 'package:dartz/dartz.dart';
import 'package:qr_awesome_generator/core/error/failure.dart';
import 'package:qr_awesome_generator/features/qr_code/domain/entities/qr_code_entity.dart';

abstract class QrCodeRepository {
  Future<Either<Failure, QrCodeEntity>> getCurrentQrCode(String id);
}
