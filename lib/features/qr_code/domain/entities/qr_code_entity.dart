// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class QrCodeEntity extends Equatable {
  final String id;
  const QrCodeEntity({required this.id});

  @override
  List<Object> get props => [id];
}
