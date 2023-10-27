import 'package:flutter_based_stocktaking_app_assignment/controllers/inventory_controller.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/main_menu_controller.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/new_document_controller.dart';
import 'package:get/get.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainMenuController());
    Get.lazyPut(() => NewDocumentController());
    Get.lazyPut(() => InventoryController());
  }
}
