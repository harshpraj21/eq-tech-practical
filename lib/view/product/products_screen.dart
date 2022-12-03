import 'package:cached_network_image/cached_network_image.dart';
import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/common/styles.dart';
import 'package:eq_tech_practical/controller/app_controller.dart';
import 'package:eq_tech_practical/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
  final AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: appbarTextStyle,
        ),
        backgroundColor: grey,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Get.toNamed(AppRoutes.addProductScreen, arguments: ['add']),
            icon: Icon(
              Icons.add,
              size: 25.h,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Obx(
        () => appController.isWaitForProducts.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: grey,
                ),
              )
            : appController.productsList.isNotEmpty
                ? ListView.builder(
                    itemCount: appController.productsList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.productDetailScreen,
                          arguments: [appController.productsList[index], index],
                        );
                      },
                      child: Card(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 65.h,
                              width: 70.w,
                              child: CachedNetworkImage(
                                imageUrl: appController
                                    .productsList[index].productImage
                                    .toString(),
                                progressIndicatorBuilder:
                                    (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                    color: grey,
                                  ),
                                ),
                              ),
                            ).paddingSymmetric(horizontal: 10.w, vertical: 8.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appController.productsList[index].productTitle
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.h,
                                    color: grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ).paddingOnly(
                                  top: 8.h,
                                ),
                                Text(
                                  appController
                                      .productsList[index].productCategory
                                      .toString(),
                                  style: productSubtitleTextStyle,
                                ).paddingSymmetric(vertical: 1.h),
                                Text(
                                  'Qty: ${appController.productsList[index].productQty}',
                                  style: productSubtitleTextStyle,
                                )
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    final data =
                                        appController.productsList[index];
                                    appController
                                        .productNameTextEditingController
                                        .text = data.productTitle.toString();
                                    appController.productCategory.value =
                                        data.productCategory.toString();
                                    appController.productCompany.value =
                                        data.productCompany.toString();
                                    appController
                                        .productDescriptionTextEditingController
                                        .text = data.productDescription.toString();
                                    appController
                                        .productPriceTextEditingController
                                        .text = data.productPrice.toString();
                                    appController
                                        .productQtyTextEditingController
                                        .text = data.productQty.toString();
                                    Get.toNamed(AppRoutes.addProductScreen,
                                        arguments: ['edit', index],);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: grey,
                                    minimumSize: const Size(75, 30),
                                  ),
                                  child: const Text('Edit'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    appController.deleteProduct(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: grey,
                                    minimumSize: const Size(75, 30),
                                  ),
                                  child: const Text('Delete'),
                                )
                              ],
                            ).paddingSymmetric(horizontal: 10.w)
                          ],
                        ),
                      ).paddingSymmetric(horizontal: 10.w, vertical: 8.h),
                    ),
                  )
                : const Text('No Products'),
      ),),
    );
  }
}
