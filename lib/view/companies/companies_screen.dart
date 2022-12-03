import 'package:eq_tech_practical/common/colors.dart';
import 'package:eq_tech_practical/common/styles.dart';
import 'package:eq_tech_practical/common/widgets/custom_text_field.dart';
import 'package:eq_tech_practical/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompaniesScreen extends StatelessWidget {
  CompaniesScreen({super.key});
  final AppController appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Company',
          style: appbarTextStyle,
        ),
        backgroundColor: grey,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: appController.addCompanyFormKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Company Name',
                    textEditingController:
                        appController.newCompanyTextEditingController,
                    validatorFunction: (val) =>
                        appController.validator(val, 'Enter Company Name'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appController.addCompany();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: grey,
                    ),
                    child: SizedBox(
                      width: Get.width,
                      child: Text(
                        'Add',
                        textAlign: TextAlign.center,
                        style: tileTextStyle,
                      ).paddingSymmetric(vertical: 10.h),
                    ),
                  ).paddingSymmetric(vertical: 20.h),
                ],
              ),
            ).paddingOnly(left: 20.w, right: 20.w, top: 20.h, bottom: 12.h),
            Text(
              'List of Companies',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 15.h,
                color: grey,
              ),
            ).paddingSymmetric(horizontal: 20.w),
            Flexible(
              child: Obx(
                () => appController.isWaitForCompanies.value
                    ? const Center(
                        child: CircularProgressIndicator(color: grey),
                      )
                    : appController.companiesList.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) => ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.h),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: white,
                                ),
                                onPressed: () {
                                  appController.deleteCompany(index);
                                },
                              ),
                              title: Text(
                                appController.companiesList[index],
                                style: tileTextStyle,
                              ),
                              tileColor: grey,
                            ).paddingSymmetric(vertical: 7.h),
                            itemCount: appController.companiesList.length,
                          ).paddingSymmetric(horizontal: 20.w, vertical: 10.h)
                        : const Text('No Companies'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
