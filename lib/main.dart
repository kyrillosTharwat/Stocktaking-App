import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/main_menu_controller.dart';
import 'package:flutter_based_stocktaking_app_assignment/services/database_service.dart';
import 'package:flutter_based_stocktaking_app_assignment/services/theme_service.dart';
import 'package:flutter_based_stocktaking_app_assignment/view/main_menu_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

import 'common/binding.dart';
import 'common/constants/colors.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.hardMintGreen));
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  await GetStorage.init();
  await MainMenuController.insertData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        initialBinding: Binding(),
        title: 'Stocktaking App',
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemNavigationBarDividerColor: Colors.transparent,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: AppColors.hardMintGreen),
          child: AnimatedSplashScreen(
            nextScreen: const MainMenuView(),
            splash: 'assets/images/splashlogo.png',
            splashIconSize: 30.h,
            duration: 500,
            backgroundColor: AppColors.hardMintGreen,
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
          ),
        ),
        theme: ThemeService().lightTheme,
        darkTheme: ThemeService().darkTheme,
        themeMode: ThemeService().getThemeMode(),
      );
    });
  }
}
