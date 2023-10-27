import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../common/widgets/experience_widgets.dart';
import '../models/item_model.dart';
import '../services/database_service.dart';

class InventoryController extends GetxController {
  final DatabaseService _database = DatabaseService();

  final TextEditingController _barcodeController = TextEditingController();

  TextEditingController get barcodeController => _barcodeController;

  late List<Item> itemsList;

  bool _isItemExist = false;

  bool get isItemExist => _isItemExist;

  Item? _searchedItem;

  Item? get searchedItem => _searchedItem;

  @override
  void onInit() async {
    super.onInit();
    await getItems();
  }

  Future<List<Item>> getItems() async {
    itemsList = [];
    try {
      itemsList = await _database.getItemsData();
      update();
    } catch (e) {
      ExpWidgets.showRedSnackBar("Error with getting data cause\n$e");
    }
    return itemsList;
  }

  void searchByBarcode() {
    if (itemsList.isNotEmpty) {
      for (var item in itemsList) {
        if (item.barcode == _barcodeController.text) {
          _isItemExist = true;
          _searchedItem = item;
          break;
        } else {
          _isItemExist = false;
        }
      }
    } else {
      ExpWidgets.showRedSnackBar(
          "Items is empty try to add some items from menu");
    }
    update();
  }
}
