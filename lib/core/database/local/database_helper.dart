import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../features/qr_code/data/data_sources/local/qr_code_database_helper.dart';
import 'business_card_database_helper.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  // Versión inicial de la base de datos
  static const int _dbVersion = 1;

  DatabaseHelper._();

  factory DatabaseHelper() {
    return _instance;
  }

  // Nombre de la base de datos
  String get databaseName => 'qr_generator_awesome.db';

  // Método para inicializar la base de datos
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  // Inicialización de la base de datos
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Creación inicial de la base de datos
  Future<void> _onCreate(Database db, int version) async {
    // Crea la nueva tabla de QR codes
    await QrCodeDatabaseHelper().createQrCodeTable(db);
    // Crea la nueva tabla de Business Cards
    await BusinessCardDatabaseHelper().createBusinessCardTable(db);
  }

  // Manejo de la actualización del esquema de la base de datos
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // print('cambio version');
      // Implementa cambios de esquema aquí para futuras versiones
      await db.execute('ALTER TABLE qrcodes ADD COLUMN newColumn TEXT');
    }
  }

  // Método para eliminar la base de datos
  Future<void> clearDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    await deleteDatabase(path); // Elimina el archivo de la base de datos
    _database = null; // Reinicia la referencia a la base de datos
    // print('Base de datos eliminada');
  }

  // Método para verificar y actualizar la base de datos tras una petición API
  Future<void> checkForDatabaseUpdates() async {
    // aqui se hace peticion a una API
    int newVersion = 2;
    final db = await database;
    int currentVersion = await db!.getVersion();

    if (newVersion > currentVersion) {
      await db.setVersion(newVersion);
      // Aquí puedes realizar cualquier migración necesaria
    }
  }
}
