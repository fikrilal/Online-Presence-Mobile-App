import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../repository/library/library_colors.dart';
import '../text/component_text.dart';

class CustomSnackbar {
  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(16.w),
          decoration: ShapeDecoration(
            color: ListColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/success.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Desc16White(message),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  static void showFailedSnackbar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        content: Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(bottom: 40.h),
          decoration: ShapeDecoration(
            color: ListColor.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/failed.svg',
                width: 24.w,
                height: 24.h,
                color: Colors.white,
              ),
              SizedBox(width: 10.w),
              Desc16White(error),
            ],
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
