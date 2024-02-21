import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../repository/library/library_colors.dart';
import '../text/component_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  CustomAppBar({required this.title, this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: onBack != null
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: ListColor.gray500),
        onPressed: onBack,
      )
          : null,
      title: ComponentTextAppBar(title),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Container(
          color: ListColor.gray200,
          height: 1.0,
        ),
      ),
      surfaceTintColor: Colors.white,
    );
  }
}
