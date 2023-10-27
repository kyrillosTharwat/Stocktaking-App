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
            $barcode TEXT NOT NULL UNIQUE,
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
  // SQL code to insert to items table
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
  // SQL code to insert to stocks table
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
  // SQL code to git items from items table
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
  // SQL code to git stocks from stocks table
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
  // SQL code to update price if wanted and quantity
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
}
