import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:controlgastos/models/transaction.dart' as MyTransaction;

class Databasehelper {
  static final Databasehelper _instance = Databasehelper.internal();
  static Database? _database;

  factory Databasehelper() {
    return _instance;
  }

  Databasehelper.internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id TEXT PRIMARY KEY,
        category TEXT,
        amount REAL,
        type TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertTransaction(MyTransaction.Transaction transaction) async {
    final db = await database;
    await db.insert('transaction', transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MyTransaction.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return MyTransaction.Transaction(
        id: maps[i]['id'],
        category: maps[i]['category'],
        description: maps[i]['description'],
        amount: maps[i]['amount'],
        type: maps[i]['type'] == 'income'
            ? MyTransaction.TransactionsTypes.income
            : MyTransaction.TransactionsTypes.income,
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTransaction(MyTransaction.Transaction transaction) async {
    final db = await database;
    await db.update('transactions', transaction.toMap(),
        where: 'id = ?', whereArgs: [transaction.id]);
  }
}
