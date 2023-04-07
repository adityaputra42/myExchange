import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../config/config.dart';

class TabBarBuySell extends StatelessWidget {
  final int? selectedIndex;
  final Function(int index)? onTap;
  const TabBarBuySell({
    Key? key,
    this.selectedIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: 35.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: selectedIndex == 0
                  ? AppColor.greenBuy
                  : const Color(0xff828282),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r))),
          onPressed: () {
            if (onTap != null) {
              onTap!(0);
            }
          },
          child: Text(
            "Buy",
            style: AppFont.semibold14.copyWith(
              color: AppColor.white,
            ),
          ),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width / 2 - 30,
        height: 35.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: selectedIndex == 1
                  ? AppColor.redSell
                  : const Color(0xff828282),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r))),
          onPressed: () {
            if (onTap != null) {
              onTap!(1);
            }
          },
          child: Text(
            "Sell",
            style: AppFont.semibold14.copyWith(
              color: AppColor.white,
            ),
          ),
        ),
      )
    ]);
  }
}
