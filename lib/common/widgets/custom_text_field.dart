import 'package:eq_tech_practical/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.textEditingController,
    this.validatorFunction,
    this.floatingLabelBehavior,
    this.textFieldMaxLines,
    this.textInputType,
  }) : super(key: key);

  final String labelText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validatorFunction;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final int? textFieldMaxLines;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorFunction,
      cursorColor: grey,
      keyboardType: textInputType,
      controller: textEditingController,
      maxLines: textFieldMaxLines ?? 1,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 16.h,
          color: grey,
        ),
        floatingLabelBehavior: floatingLabelBehavior,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ).paddingSymmetric(vertical: 8.h);
  }
}
