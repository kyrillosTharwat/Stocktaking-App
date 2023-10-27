import 'package:flutter_based_stocktaking_app_assignment/services/database_service.dart';
import 'package:get/get.dart';

import '../models/item_model.dart';

class MainMenuController extends GetxController {
  static final DatabaseService _database = DatabaseService();

  static List<Item> items = [
    Item(quantity: 1, barcode: '1', itemId: '1', price: 10, name: 'item1'),
    Item(quantity: 2, barcode: '2', itemId: '2', price: 20, name: 'item2'),
    Item(quantity: 3, barcode: '3', itemId: '3', price: 30, name: 'item3'),
    Item(quantity: 4, barcode: '4', itemId: '4', price: 40, name: 'item4'),
    Item(quantity: 5, barcode: '5', itemId: '5', price: 50, name: 'item5'),
    Item(quantity: 6, barcode: '6', itemId: '6', price: 60, name: 'item6'),
    Item(quantity: 7, barcode: '7', itemId: '7', price: 70, name: 'item7'),
    Item(quantity: 8, barcode: '8', itemId: '8', price: 80, name: 'item8'),
    Item(quantity: 9, barcode: '9', itemId: '9', price: 90, name: 'item9'),
  ];

  static Future<void> insertData() async {
    for (var item in items) {
      try {
        await _database.insertIntoItems(item: item);
      } catch (e) {
        e;
      }
    }
  }
  void onSwitchChange(bool value) {
    value = !value;
    update();
  }
}
