import 'package:sqflite/sqflite.dart';

import '../../../../../core/database/local/database_helper.dart';
import '../../models/qr_code_model.dart';

// Nombre de la tabla para el modelo QrCodeModel
const String tableQrCode = 'qr_codes';

class QrCodeDatabaseHelper {
  // Método para crear la tabla qrcodes
  Future<void> createQrCodeTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableQrCode (
      id TEXT PRIMARY KEY NOT NULL,
      type TEXT NOT NULL,
      data TEXT,
      comment TEXT,
      size DOUBLE,
      padding DOUBLE,
      gapless BOOLEAN,
      eye_type TEXT,
      point_type TEXT,
      phone TEXT,
      message TEXT,
      url TEXT,
      description TEXT,
      text TEXT,
      name TEXT,
      email TEXT,
      address TEXT,
      city TEXT,
      country TEXT,
      enterprise TEXT,
      note TEXT,
      subject TEXT,
      ssid TEXT,
      password TEXT,
      encryption TEXT,
      hidden BOOLEAN,
      event_title TEXT,
      event_start_date TEXT,
      event_end_date TEXT,
      latitude DOUBLE,
      longitude DOUBLE,
      background_color TEXT,
      eye_color TEXT,
      point_color TEXT,
      qr_background_color TEXT,
      favorite BOOLEAN DEFAULT FALSE
    )
  ''');
  }

  // Métodos específicos de QrCodeModel

  // Método para insertar un nuevo QR Code
  Future<int> insertQrCode(QrCodeModel qrCode) async {
    final Database? db = await DatabaseHelper().database;
    return await db!.insert(
      tableQrCode,
      qrCode.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para obtener todos los QR Codes
  Future<List<QrCodeModel>> getQrCodes() async {
    final Database? db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db!.query(tableQrCode);

    return List.generate(maps.length, (i) {
      return QrCodeModel.fromJson(maps[i]);
    });
  }
}
