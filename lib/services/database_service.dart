import 'package:flutter_based_stocktaking_app_assignment/models/item_model.dart';
import 'package:flutter_based_stocktaking_app_assignment/models/stock_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const items = 'items';
  static const stocks = 'stocks';

  static const itemId = 'itemId';
  static const name = 'name';
  static const quantity = 'quantity';
  static const price = 'price';
  static const barcode = 'barcode';

  static const stockId = 'stockId';
  static const documentNum = 'documentNum';
  static const time = 'time';

  static late Database _db;

  // this opens the database (and creates it if it doesn't exist)
  static Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database tables
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $items (
            $itemId TEXT NOT NULL,
            $name TEXT NOT NULL,
            $quantity DOUBLE NOT NULL,
            $price DOUBLE NOT NULL,
            $barcode TEXT NOT NULL,
            PRIMARY KEY ($itemId)
          );
          ''');
    await db.execute('''
          CREATE TABLE $stocks (
            $documentNum INTEGER NOT NULL,
            $time TEXT NOT NULL,
            $itemId TEXT NOT NULL,
            $quantity DOUBLE NOT NULL,
            PRIMARY KEY ($documentNum, $time, $itemId),
            FOREIGN KEY($itemId) REFERENCES $items($itemId)
          );
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(items, row);
  }

  Future<int> insertIntoItems({required Item item}) async {
    return await _db.transaction((txn) async {
      return txn
          .rawInsert('INSERT INTO $items('
              '$quantity,'
              '$barcode,'
              '$itemId,'
              '$price,'
              '$name'
              ') VALUES('
              '"${item.quantity}",'
              '"${item.barcode}",'
              '"${item.itemId}",'
              '"${item.price}",'
              '"${item.name}"'
              ')')
          .then((value) => value)
          .catchError((e) => e);
    });
  }

  Future<int> insertIntoStocks({required Stock stock}) async {
    return await _db.transaction((txn) async {
      return txn
          .rawInsert('INSERT INTO $stocks('
              '$documentNum,'
              '$quantity,'
              '$itemId,'
              '$time'
              ') VALUES('
              '"${stock.documentNum}",'
              '"${stock.quantity}",'
              '"${stock.itemId}",'
              '"${stock.time}"'
              ')')
          .then((value) => value)
          .catchError((e) => e);
    });
  }

  Future<List<Item>> getItemsData() async {
    List<Item> itemsList = [];
    List<Item> listFromJson(List<Map<String, dynamic>> jsonData) {
      List<Item> result = [];

      for (var item in jsonData) {
        result.add(Item.fromJson(item));
      }
      return result;
    }

    await _db.rawQuery('SELECT * FROM $items').then((value) {
      itemsList = listFromJson(value);
    }).catchError((e) {});
    return itemsList;
  }

  Future<List<Stock>> getStocksData() async {
    List<Stock> stocksList = [];
    List<Stock> listFromJson(List<Map<String, dynamic>> jsonData) {
      List<Stock> result = [];

      for (var stock in jsonData) {
        result.add(Stock.fromJson(stock));
      }
      return result;
    }

    await _db.rawQuery('SELECT * FROM $stocks').then((value) {
      stocksList = listFromJson(value);
    }).catchError((e) {});
    return stocksList;
  }

  Future<int> updateItemPriceAndQuantity({
    required double newPrice,
    required double newQuantity,
    required String itemBarcode,
  }) async {
    return await _db.transaction((txn) async {
      return txn
          .rawUpdate('''
      UPDATE $items
      SET $price = ?,
          $quantity = ?
      WHERE $barcode = ?
    ''', [newPrice, newQuantity, itemBarcode])
          .then((value) => value)
          .catchError((e) => e);
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(items);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $items');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    int id = row[itemId];
    return await _db.update(
      items,
      row,
      where: '$itemId = ?',
      whereArgs: [id],
    );
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    return await _db.delete(
      items,
      where: '$itemId = ?',
      whereArgs: [id],
    );
  }
}
