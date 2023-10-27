import 'package:flutter/material.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/main_menu_controller.dart';
import 'package:flutter_based_stocktaking_app_assignment/view/inventory_view.dart';
import 'package:flutter_based_stocktaking_app_assignment/view/new_document_view.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../common/constants/colors.dart';
import '../services/theme_service.dart';

class MainMenuView extends StatelessWidget {
  const MainMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainMenuController>(
        init: MainMenuController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Welcome',
                style:
                    TextStyle(fontSize: 18.sp, color: AppColors.hardMintGreen),
              ),
              actions: [
                Icon(
                 Ionicons.moon,
                 size: 25.sp,
               ),
                Switch(
                  activeColor: AppColors.hardMintGreen,
                  value: ThemeService().isSavedDarkMode(),
                  onChanged: (value) {
                   controller.onSwitchChange(value);
                   ThemeService().changeTheme();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.h, 2.h, 0, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const NewDocumentView(),
                          duration: const Duration(milliseconds: 400),
                          transition: Transition.rightToLeftWithFade,
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: AppColors.regularMintGreen,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Image.asset(
                                  'assets/images/addNew.png',
                                  width: 35.w,
                                  height: 35.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              'New \nStocktaking\nDocument',
                              overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.hardMintGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const InventoryView(),
                          duration: const Duration(milliseconds: 400),
                          transition: Transition.rightToLeftWithFade,
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: AppColors.regularMintGreen,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Image.asset(
                                  'assets/images/inventory.png',
                                  width: 35.w,
                                  height: 35.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              'Check\nInventory',
                              overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.hardMintGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
