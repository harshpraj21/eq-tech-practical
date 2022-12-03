import 'dart:io';

import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/common/styles.dart';
import 'package:eq_tech_practical/common/widgets/custom_dropdown.dart';
import 'package:eq_tech_practical/common/widgets/custom_text_field.dart';
import 'package:eq_tech_practical/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});
  final AppController appController = Get.find<AppController>();
  final data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Product',
          style: appbarTextStyle,
        ),
        backgroundColor: grey,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: appController.addProductFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  labelText: 'Product Name',
                  validatorFunction: (p0) =>
                      appController.validator(p0, 'Enter Product Name'),
                  textEditingController:
                      appController.productNameTextEditingController,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                Obx(
                  () => CustomDropdown(
                    dropDownHintText: 'Category',
                    validator: (val) {
                      if (val == null) {
                        return 'Select Category';
                      }
                      return null;
                    },
                    dropDownValue:
                        appController.productCategory.value.isNotEmpty
                            ? appController.productCategory.value
                            : null,
                    dropDownitems: appController.categoriesList
                        .map(
                          (selectedCategory) => DropdownMenuItem(
                            value: selectedCategory,
                            child: Text(selectedCategory),
                          ),
                        )
                        .toList(),
                    dropDownOnChanged: (value) =>
                        appController.productCategory.value = value.toString(),
                  ),
                ),
                Obx(
                  () => CustomDropdown(
                    dropDownHintText: 'Company',
                    validator: (val) {
                      if (val == null) {
                        return 'Select Company';
                      }
                      return null;
                    },
                    dropDownValue: appController.productCompany.value.isNotEmpty
                        ? appController.productCompany.value
                        : null,
                    dropDownitems: appController.companiesList
                        .map(
                          (selectedCompany) => DropdownMenuItem(
                            value: selectedCompany,
                            child: Text(
                              selectedCompany,
                            ),
                          ),
                        )
                        .toList(),
                    dropDownOnChanged: (value) =>
                        appController.productCompany.value = value.toString(),
                  ),
                ),
                CustomTextFormField(
                  labelText: 'Description',
                  validatorFunction: (val) =>
                      appController.validator(val, 'Enter Description'),
                  textEditingController:
                      appController.productDescriptionTextEditingController,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  textFieldMaxLines: 4,
                ),
                CustomTextFormField(
                  labelText: 'Price',
                  validatorFunction: (val) =>
                      appController.validator(val, 'Enter Price'),
                  textEditingController:
                      appController.productPriceTextEditingController,
                  textInputType: TextInputType.number,
                ),
                CustomTextFormField(
                  labelText: 'Qty',
                  validatorFunction: (val) =>
                      appController.validator(val, 'Enter Quantity'),
                  textEditingController:
                      appController.productQtyTextEditingController,
                  textInputType: TextInputType.number,
                ),
                Text(
                  'Upload Image:',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.h,
                    color: grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    appController.selectGeneralImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => appController.generalImage.isEmpty
                            ? Container(
                                height: 40.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: grey, width: 0.2.w),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: grey,
                                ),
                              )
                            : Image.file(
                                File(appController.generalImage.value),
                                fit: BoxFit.cover,
                                width: 70.w,
                                height: 40.h,
                              ),
                      ),
                      Container(
                        height: 40.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: grey, width: 0.2.w),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: grey, width: 0.2.w),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: grey,
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: grey, width: 0.2.w),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: grey,
                        ),
                      )
                    ],
                  ),
                ).paddingSymmetric(vertical: 8.h),
                Obx(() => appController.isUploading.value
                    ? const SpinKitThreeBounce(
                        color: grey,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (data[0] == 'add') {
                            appController.addProduct();
                          } else if (data[0] == 'edit') {
                            appController.editProduct(data[1]);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: grey,
                        ),
                        child: SizedBox(
                          width: Get.width,
                          child: Text(
                            'Save',
                            textAlign: TextAlign.center,
                            style: tileTextStyle,
                          ).paddingSymmetric(vertical: 10.h),
                        ),
                      ).paddingSymmetric(vertical: 10.h),),
              ],
            ),
          ).paddingSymmetric(horizontal: 20.w, vertical: 15.h),
        ),
      ),
    );
  }
}
