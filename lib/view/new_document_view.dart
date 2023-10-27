import 'package:flutter/material.dart';
import 'package:flutter_based_stocktaking_app_assignment/common/widgets/buttons.dart';
import 'package:flutter_based_stocktaking_app_assignment/common/widgets/text_form.dart';
import 'package:flutter_based_stocktaking_app_assignment/controllers/new_document_controller.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

import '../common/constants/colors.dart';
import '../common/widgets/experience_widgets.dart';
import '../models/item_model.dart';

class NewDocumentView extends StatelessWidget {
  const NewDocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewDocumentController>(
        init: NewDocumentController(),
        builder: (controller) {
          controller = Get.put<NewDocumentController>(NewDocumentController());
          return controller.isUploading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.regularMintGreen,
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      controller.stocksList.isEmpty
                          ? 'Document Number 1'
                          : 'Document Number ${controller.stocksList.last.documentNum + 1}',
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
                      padding: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 45.w,
                                  child: TextForm(
                                    controller: controller.barcodeController,
                                    title: 'Barcode',
                                    icon: Ionicons.barcode_outline,
                                    hintText: 'From 1 to 9 ',
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 45.w,
                                  child: TextForm(
                                    keyboardType: TextInputType.number,
                                    controller: controller.quantityController,
                                    title: 'Quantity',
                                    icon: Icons.balance_outlined,
                                    hintText: 'Minimum 1 quantity',
                                    canBeEmpty: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                              child: outlineIconButton(
                                  buttonText: 'ADD STOCK',
                                  buttonIcon: Ionicons.add_circle_outline,
                                  height: 6.h,
                                  width: double.maxFinite,
                                  function: () {
                                    controller.searchByBarcode();
                                    controller.isItemExist == false
                                        ? ExpWidgets.showRedSnackBar(
                                            "Barcode is incorrect")
                                        : null;
                                    controller.quantityController.clear();
                                    controller.barcodeController.clear();
                                  })),
                          SizedBox(
                            height: 1.h,
                          ),
                          controller.searchedList!.isNotEmpty
                              ? Text(
                                  'Swap Item left and right to Delete',
                                  overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                  style: TextStyle(
                                    color: AppColors.lightGrey,
                                    fontSize: 16.sp,
                                  ),
                                )
                              : Text(
                                  'Add Item to your Stock',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.lightGrey,
                                    fontSize: 16.sp,
                                  ),
                                ),
                          SizedBox(
                            height: 2.h,
                          ),
                          controller.searchedList!.isEmpty
                              ? Image.asset(
                                  'assets/images/emptyStock.png',
                                  width: 90.w,
                                  height: 90.w,
                                  fit: BoxFit.cover,
                                )
                              : ListView.separated(
                                  itemBuilder: (context, index) =>
                                      buildListItem(
                                          controller.searchedList![index],
                                          index),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(),
                                  itemCount: controller.searchedList!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                ),
                          const Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Center(
                              child: filledIconButton(
                                  buttonText: 'SAVE',
                                  buttonIcon: Ionicons.checkbox,
                                  height: 6.h,
                                  width: double.maxFinite,
                                  function: () {
                                    controller.searchedList!.isEmpty
                                        ? ExpWidgets.showRedSnackBar(
                                            "There are no Stocks in Your List")
                                        : controller.insertStocksList();
                                  })),
                          SizedBox(
                            height: 1.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
  }
}

Widget buildListItem(Item? item, index) {
  return GetBuilder<NewDocumentController>(builder: (controller) {
    controller = Get.find<NewDocumentController>();
    return Dismissible(
      key: ObjectKey(item),
      onDismissed: (direction) {
        controller.deleteItem(index);
      },
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
                borderRadius: BorderRadius.circular(12.sp),
                child: Image.asset(
                  'assets/images/item.png',
                  width: 25.w,
                  height: 25.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item Name: ${item!.name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Old Quantity: ${item.quantity.toInt() - controller.enteredQuantityList[index].toInt()} ',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'New Quantity: ${item.quantity.toInt()} ',
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });
}
