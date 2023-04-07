import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class CustomTabBar extends StatelessWidget {
  final int? selectedIndex;
  final List<String> titles;
  final Function(int)? onTap;
  final double fonsize;
  const CustomTabBar({
    Key? key,
    required this.titles,
    this.selectedIndex,
    this.fonsize = 14,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: titles
          .map((e) => GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!(titles.indexOf(e));
                  }
                },
                child: Container(
                  width: 100.w,
                  height: AppDimension.h32,
                  margin: EdgeInsets.only(
                      right:
                          e == titles.last ? AppDimension.w16 : AppDimension.w8,
                      left: e == titles.first ? AppDimension.w16 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: titles.indexOf(e) == selectedIndex
                        ? AppColor.primaryColor
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      e,
                      style: AppFont.reguler12.copyWith(
                          color: titles.indexOf(e) == selectedIndex
                              ? AppColor.white
                              : AppColor.darkerGray,
                          fontSize: fonsize,
                          fontWeight: titles.indexOf(e) == selectedIndex
                              ? AppFontWeight.medium
                              : AppFontWeight.regular),
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
