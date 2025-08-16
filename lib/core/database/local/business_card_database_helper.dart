import 'package:sqflite/sqflite.dart';
import '../../utils/params_util.dart';
import './database_helper.dart';
import '../../../models/business_card_model.dart';

// Nombre de la tabla para el modelo BusinessCardModel
const String tableBusinessCards = 'business_cards';

class BusinessCardDatabaseHelper {
  // Método para crear la tabla 'business_cards'
  Future<void> createBusinessCardTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableBusinessCards (
      business_card_id TEXT PRIMARY KEY NOT NULL,
      qr_code_id TEXT NOT NULL,
      main_text TEXT NOT NULL,
      secondary_text TEXT,
      layout_type INTEGER NOT NULL,
      is_gradient INTEGER NOT NULL,
      color1_value INTEGER NOT NULL,
      color2_value INTEGER,
      gradient_direction TEXT,
      favorite VARCHAR(2),
      FOREIGN KEY (qr_code_id) REFERENCES qr_codes (id) ON DELETE CASCADE
    )
    ''');
  }

  // Método para insertar una nueva Tarjeta de Presentación
  Future<int> insertBusinessCard(BusinessCardModel businessCard) async {
    final Database? db = await DatabaseHelper().database;
    if (db == null) {
      throw Exception('Database is not initialized.');
    }
    return await db.insert(
      tableBusinessCards,
      businessCard.toJson(),
      // Si ya existe una tarjeta para este QR Code, la reemplaza
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para obtener una Tarjeta de Presentación por su ID de QR Code
  Future<BusinessCardModel?> getBusinessCardByQrCodeId(String qrCodeId) async {
    final Database? db = await DatabaseHelper().database;
    if (db == null) {
      throw Exception('Database is not initialized.');
    }
    final List<Map<String, dynamic>> maps = await db.query(
      tableBusinessCards,
      where: 'qr_code_id = ?',
      whereArgs: [qrCodeId],
      limit: 1, // Esperamos solo una tarjeta por cada QR Code
    );

    if (maps.isNotEmpty) {
      return BusinessCardModel.fromJson(maps.first);
    }
    return null;
  }

  // Método para obtener todos los QR Codes
  Future<List<BusinessCardModel>> getBusinessCards(
      {Map<String, dynamic>? filters}) async {
    final Database? db = await DatabaseHelper().database;
    final Map<String, dynamic> newFilters = ParamsUtil.paramsCamelToSnakeCase(
      filters: filters,
    );
    final List<String> whereClauses = ParamsUtil.generateWhereClauses(
      filters: newFilters,
    );
    final List<dynamic> whereArgs = ParamsUtil.generateWhereArgs(
      filters: newFilters,
    );
    // final List<Map<String, dynamic>> maps = await db!.query(tableQrCode);

    final String whereString = whereClauses.isNotEmpty
        ? whereClauses.join(' AND ')
        : ''; // Sin WHERE si no hay filtros válidos

    final List<Map<String, dynamic>> maps = await db!.query(
      tableBusinessCards,
      where: whereString.isNotEmpty ? whereString : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return List.generate(maps.length, (i) {
      return BusinessCardModel.fromJson(maps[i]);
    });
  }

  // Método para actualizar una Tarjeta de Presentación existente
  Future<int> updateBusinessCard(BusinessCardModel businessCard) async {
    final Database? db = await DatabaseHelper().database;
    if (db == null) {
      throw Exception('Database is not initialized.');
    }
    return await db.update(
      tableBusinessCards,
      businessCard.toJson(),
      where: 'qr_code_id = ?',
      whereArgs: [businessCard.qrCodeId],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método de conveniencia para insertar o actualizar (upsert)
  Future<int> saveBusinessCard(BusinessCardModel businessCard) async {
    return await insertBusinessCard(businessCard);
  }

  // Método para actualizar la prop favorite
  Future<int> updateFavorite(String businessCardId, String favorite) async {
    final Database? db = await DatabaseHelper().database;

    return await db!.rawUpdate(
      'UPDATE $tableBusinessCards SET favorite = ? WHERE business_card_id = ?',
      [favorite, businessCardId], // Valores para los placeholders `?`
    );
  }
}
