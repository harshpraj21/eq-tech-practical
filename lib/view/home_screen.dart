import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/common/styles.dart';
import 'package:eq_tech_practical/controller/app_controller.dart';
import 'package:eq_tech_practical/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AppController appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Home',
          style: appbarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: grey,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CustomButton(
              buttonTitle: 'Products',
              buttonOnTap: () {
                appController.getCategories();
                appController.getCompanies();
                appController.getProducts();
                Get.toNamed(AppRoutes.productsScreen);
              },
            ),
            CustomButton(
              buttonTitle: 'Manage Category',
              buttonOnTap: () {
                appController.getCategories();
                Get.toNamed(AppRoutes.manageCategoryScreen);
              },
            ),
            CustomButton(
              buttonTitle: 'Manage Company',
              buttonOnTap: () {
                appController.getCompanies();
                Get.toNamed(AppRoutes.manageCompanyScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonTitle,
    required this.buttonOnTap,
  }) : super(key: key);
  final String buttonTitle;
  final Function() buttonOnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonOnTap,
      child: Container(
        height: 170.h,
        width: Get.width,
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(5)),
        child: Align(
          child: Text(
            buttonTitle,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 22.h,
              color: white,
            ),
          ),
        ),
      ).paddingSymmetric(horizontal: 20.w),
    );
  }
}
