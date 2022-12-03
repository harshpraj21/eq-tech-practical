import 'package:cached_network_image/cached_network_image.dart';
import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/common/styles.dart';
import 'package:eq_tech_practical/controller/app_controller.dart';
import 'package:eq_tech_practical/model/product_model.dart';
import 'package:eq_tech_practical/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({
    super.key,
  });
  final AppController appController = Get.find<AppController>();

  var data = Get.arguments;
  @override
  Widget build(BuildContext context) {
    final ProductModel product = data[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Screen',
          style: appbarTextStyle,
        ),
        backgroundColor: grey,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150.h,
              width: Get.width,
              child: CachedNetworkImage(
                imageUrl: product.productImage.toString(),
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: grey,
                  ),
                ),
              ),
            ).paddingSymmetric(horizontal: 20.w, vertical: 12.h),
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      product.productTitle.toString(),
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.h,
                        color: grey,
                      ),
                    ),
                    Text(
                      product.productCategory.toString(),
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.h,
                        color: grey,
                      ),
                    )
                  ],
                ),
                Text(
                  'Price: ${product.productPrice}/-',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.h,
                    color: grey,
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 20.w),
            SizedBox(
              height: 15.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.productCompany.toString(),
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.h,
                    color: grey,
                  ),
                ),
                Text(
                  'Qty: ${product.productQty}',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.h,
                    color: grey,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
            SizedBox(
              height: 35.h,
            ),
            Text(
              'Description:',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 16.h,
                color: grey,
              ),
            ).paddingSymmetric(horizontal: 20.w),
            Text(
              product.productDescription.toString(),
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w300,
                fontSize: 13.h,
                color: grey,
              ),
            ).paddingSymmetric(horizontal: 20.w, vertical: 5.h),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      appController.productNameTextEditingController.text =
                          product.productTitle.toString();
                      appController.productCategory.value =
                          product.productCategory.toString();
                      appController.productCompany.value =
                          product.productCompany.toString();
                      appController.productDescriptionTextEditingController
                          .text = product.productDescription.toString();
                      appController.productPriceTextEditingController.text =
                          product.productPrice.toString();
                      appController.productQtyTextEditingController.text =
                          product.productQty.toString();
                      Get.offAndToNamed(AppRoutes.addProductScreen,
                          arguments: ['edit', data[1]],);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: grey,
                    ),
                    child: SizedBox(
                      child: Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: tileTextStyle,
                      ).paddingSymmetric(vertical: 10.h),
                    ),
                  ).paddingSymmetric(vertical: 20.h, horizontal: 8.w),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      appController.deleteProduct(data[1]);
                      Get.snackbar(
                        'Product Deleted',
                        'Product Deleted Successfully',
                      );
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: grey,
                    ),
                    child: SizedBox(
                      child: Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: tileTextStyle,
                      ).paddingSymmetric(vertical: 10.h),
                    ),
                  ).paddingSymmetric(vertical: 20.h, horizontal: 8.w),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w)
          ],
        ),
      ),
    );
  }
}
