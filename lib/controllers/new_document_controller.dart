import 'package:flutter/material.dart';
import 'package:flutter_based_stocktaking_app_assignment/common/widgets/experience_widgets.dart';
import 'package:flutter_based_stocktaking_app_assignment/services/database_service.dart';
import 'package:flutter_based_stocktaking_app_assignment/view/main_menu_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/item_model.dart';
import '../models/stock_model.dart';

class NewDocumentController extends GetxController {
  final DatabaseService _database = DatabaseService();
  late List<Item> itemsList;

  List<Stock> _stocksList = [];

  List<Stock> get stocksList => _stocksList;

  final List<Item> _searchedList = [];

  List<Item>? get searchedList => _searchedList;

  bool _isUploading = false;

  bool get isUploading => _isUploading;

  bool? _isItemExist;

  bool? get isItemExist => _isItemExist;

  final TextEditingController _barcodeController = TextEditingController();

  final TextEditingController _quantityController = TextEditingController();

  TextEditingController get barcodeController => _barcodeController;

  TextEditingController get quantityController => _quantityController;

  List<Stock> stocksToUpload = [];

  final List<double> _enteredQuantityList = [];

  List<double> get enteredQuantityList => _enteredQuantityList;

  @override
  void onInit() async {
    super.onInit();
    await getItems();
    await getStocks();
    _isUploading = false;
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

  Future<List<Stock>> getStocks() async {
    _stocksList = [];
    try {
      _stocksList = await _database.getStocksData();
      update();
    } catch (e) {
      ExpWidgets.showRedSnackBar("Stock is empty");
    }
    return _stocksList;
  }

  void searchByBarcode() {
    if (itemsList.isNotEmpty) {
      for (var item in itemsList) {
        if (item.barcode == _barcodeController.text) {
          _isItemExist = true;
          if (searchedList!.contains(item) == true) {
            ExpWidgets.showRedSnackBar("Item is already exist");
            break;
          }
          if (double.tryParse(_quantityController.text) == 0 &&
              _quantityController.text.isNotEmpty) {
            ExpWidgets.showRedSnackBar("Quantity can't be zero");
            break;
          }
          _enteredQuantityList
              .add(double.tryParse(_quantityController.text) ?? 1.0);
          item.quantity += double.tryParse(_quantityController.text) ?? 1.0;
          _searchedList.add(item);
          break;
        } else {
          _isItemExist = false;
        }
      }
    } else {
      ExpWidgets.showRedSnackBar(
          "Items is empty");
    }
    update();
  }

  Future<void> insertStocksList() async {
    for (Item item in _searchedList) {
      Stock stock = Stock(
        documentNum: _stocksList.isEmpty ? 1 : _stocksList.last.documentNum + 1,
        quantity: item.quantity,
        itemId: item.itemId,
        time: DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.now()), // Format the current time
      );
      stocksToUpload.add(stock);
    }
    for (Stock stock in stocksToUpload) {
      _isUploading = true;
      try {
        await _database.insertIntoStocks(stock: stock);
        await updateItems();
        _isUploading = false;
        Get.offAll(
          () => const MainMenuView(),
          duration: const Duration(milliseconds: 400),
          transition: Transition.leftToRightWithFade,
        );
        update();
        ExpWidgets.showGreenSnackBar(
            "Your Stocks List is Uploaded successfully");
        break;
      } catch (e) {
        ExpWidgets.showRedSnackBar('Can\'t upload your list');
        break;
      }
    }
  }

  Future<void> updateItems() async {
    for (Item item in _searchedList) {
      await _database.updateItemPriceAndQuantity(
        newPrice: item.price,
        newQuantity: item.quantity,
        itemBarcode: item.barcode,
      );
    }
  }
  void deleteItem(index) {
    _searchedList[index].quantity -= _enteredQuantityList[index];
    _searchedList.removeAt(index);
    update();
  }
}
