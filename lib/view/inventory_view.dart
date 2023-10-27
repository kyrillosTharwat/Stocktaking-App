import 'package:flutter/material.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/inventory_controller.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../common/constants/colors.dart';
import '../common/widgets/experience_widgets.dart';
import '../common/widgets/text_form.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Inventory',
                overflow: TextOverflow.ellipsis,
                // maxLines: 1,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0),
                child: Column(
                  children: [
                    TextForm(
                        controller: controller.barcodeController,
                        title: 'Barcode Search ',
                        icon: Ionicons.barcode_outline,
                        hintText: 'From 1 to 9 ',
                        onSubmit: (value){
                          if(controller.isItemExist == false) {
                          ExpWidgets.showRedSnackBar("Barcode Is Incorrect");
                          controller.searchByBarcode();
                        }},
                        onChange: (value) {
                          controller.searchByBarcode();
                        }),
                    controller.isItemExist
                        ? Padding(
                          padding:  EdgeInsets.only(top: 2.h),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                color: AppColors.regularMintGreen,
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(12.sp),
                                    child: Image.asset(
                                      'assets/images/item.png',
                                      width: 25.w,
                                      height: 25.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Item Name: ${controller.searchedItem!.name}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'Quantity: ${controller.searchedItem!.quantity.toInt()} ',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'Price: ${controller.searchedItem!.price.toInt()} ',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      'Total price: ${controller.searchedItem!.price.toInt() * controller.searchedItem!.quantity.toInt()} ',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        : Image.asset(
                            'assets/images/emptyStock.png',
                            width: 90.w,
                            height: 90.w,
                            fit: BoxFit.cover,
                          ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
