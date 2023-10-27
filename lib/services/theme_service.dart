import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../common/constants/colors.dart';

class ThemeService {
  final _getStorage = GetStorage();

  final _darkThemeKey = 'isDarkTheme';

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.hardMintGreen,
    primarySwatch: mintMaterial,
    fontFamily: 'Ubuntu'
  );

  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.hardMintGreen,
    primarySwatch: mintMaterial,
    fontFamily: 'Ubuntu'
  );

  void saveThemeData(bool isDarkMode) {
    _getStorage.write(_darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return _getStorage.read(_darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }
}

Map<int, Color> mainColor = {
  50: const Color.fromRGBO(53, 187, 155, .1),
  100: const Color.fromRGBO(53, 187, 155, .2),
  200: const Color.fromRGBO(53, 187, 155, .3),
  300: const Color.fromRGBO(53, 187, 155, .4),
  400: const Color.fromRGBO(53, 187, 155, .5),
  500: const Color.fromRGBO(53, 187, 155, .6),
  600: const Color.fromRGBO(53, 187, 155, .7),
  700: const Color.fromRGBO(53, 187, 155, .8),
  800: const Color.fromRGBO(53, 187, 155, .9),
  900: const Color.fromRGBO(53, 187, 155, 1),
};
MaterialColor mintMaterial = MaterialColor(0xFF35BB9B, mainColor);
