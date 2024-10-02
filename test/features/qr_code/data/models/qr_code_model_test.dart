import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:qr_awesome_generator/features/qr_code/data/models/qr_code_model.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  const testQrCodeModel = QrCodeModel(
    id: 'soyIdUno'
  );
  test('should be a subclass of qr code entity', () async {
    //assert
    expect(testQrCodeModel, isA<QrCodeModel>());
  });
  test('should return a valid qr code model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_qr_code_response.json')
    );
    //act
    final result = QrCodeModel.fromJson(jsonMap);
    //assert
    expect(result, testQrCodeModel);
  });
  test('should return a valid json from qr code model', () async {
    //act
    final result = testQrCodeModel.toJson();
    //assert
    final expectedJson = {
      'id': 'soyIdUno'
    };
    expect(result, expectedJson);
  });
}