import 'package:eq_tech_practical/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    Key? key,
    this.dropDownHintText,
    required this.dropDownValue,
    required this.dropDownitems,
    required this.dropDownOnChanged,
    this.validator,
  }) : super(key: key);

  final String? dropDownHintText;
  final String? dropDownValue;
  final List<DropdownMenuItem<String>> dropDownitems;
  final void Function(String?)? dropDownOnChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
          ),
          borderRadius: BorderRadius.circular(5.h),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: grey,
          ),
          borderRadius: BorderRadius.circular(5.h),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5.h),
        ),
      ),
      validator: validator,
      isExpanded: true,
      icon: Icon(
        Icons.arrow_drop_down,
        size: 20.h,
        color: grey,
      ),
      hint: Text(
        dropDownHintText ?? '',
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.w400,
          fontSize: 14.h,
          color: grey,
        ),
      ),
      value: dropDownValue,
      items: dropDownitems,
      onChanged: dropDownOnChanged,
    ).paddingSymmetric(vertical: 8.h);
  }
}
