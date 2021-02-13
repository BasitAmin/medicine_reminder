import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medicine_reminder/model/Medicine.dart';

class MedicineDb {
  String path;

  MedicineDb._();

  static final MedicineDb db = MedicineDb._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'medicine.db');
    print("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE Medicine (_id INTEGER PRIMARY KEY, name TEXT, startDate DATE, endDate TEXT, time TEXT, type TEXT);');
          print('New table created at $path');
        });
  }

  Future<List<Medicine>> getMedicineFromDB() async {
    final db = await database;
    List<Medicine> MedicineList = [];
    List<Map> maps = await db.query('Medicine',
        columns: ['_id', 'name', 'startDate', 'endDate', 'time','type']);
    if (maps.length > 0) {
      maps.forEach((map) {
        MedicineList.add(Medicine.fromMap(map));
      });
    }
    return MedicineList;
  }

  updateMedicineInDB(Medicine updatedMedicine) async {
    final db = await database;
    await db.update('Medicine', updatedMedicine.toMap(),
        where: '_id = ?', whereArgs: [updatedMedicine.id]);
    print('Medicine updated: ${updatedMedicine.name} ${updatedMedicine.type}');
  }

  deleteMedicineInDB(Medicine MedicineToDelete) async {
    final db = await database;
    await db.delete('Medicine', where: '_id = ?', whereArgs: [MedicineToDelete.id]);
    print('Medicine deleted');
  }

  Future<Medicine> addMedicineInDB(Medicine newMedicine) async {
    final db = await database;
    if (newMedicine.name.trim().isEmpty) newMedicine.name = 'Untitled Medicine';
    int id = await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into Medicine(name, startDate, endDate, time,type) VALUES ("${newMedicine.name}", "${newMedicine.startDate}", "${newMedicine.endDate}", "${newMedicine.time}", "${newMedicine.type}");');
    });
    newMedicine.id = id;
    print('Medicine added: ${newMedicine.name} ${newMedicine.type}');
    return newMedicine;
  }
}
