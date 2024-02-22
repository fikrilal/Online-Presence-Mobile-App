import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../repository/library/library_colors.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ListColor.gray200, // Color of the border
              width: 1.0, // Thickness of the border
            ),
          ),
        ),
        child: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomAppBarItem(Hicons.home_3_light_outline, Hicons.home_3_bold, 'Home', 0),
                _bottomAppBarItem(Hicons.category_light_outline, Hicons.category_bold, 'Proyek', 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(IconData icon, IconData activeIcon, String label, int page) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = page;
        });
        _goBranch(selectedIndex);
      },
      child: ZoomTapAnimation(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selectedIndex == page ? activeIcon : icon,
              color: selectedIndex == page ? ListColor.primary : ListColor.gray400,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == page ? ListColor.primary : ListColor.gray400,
                fontSize: 15,
                fontWeight: selectedIndex == page ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
