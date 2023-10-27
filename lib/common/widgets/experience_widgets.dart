import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ExpWidgets {
  ExpWidgets._();

  static showGreenSnackBar(String body) {
    Get.snackbar('Process Successful', body,
        duration: const Duration(milliseconds: 1500),
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }

  static showRedSnackBar(String body) {
    Get.snackbar('Process Faild', body,
        duration: const Duration(milliseconds: 1500),
        margin: const EdgeInsets.all(10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }


  static showCustomSnackBar(String head, String body, Color color) {
    Get.snackbar(head, body,
        duration: const Duration(milliseconds: 4500),
        margin: const EdgeInsets.all(10),
        backgroundColor: color,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM);
  }
}
