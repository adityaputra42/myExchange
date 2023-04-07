import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buttonMenu({required IconData icon, required String title}) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.29,
        height: 42.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 0.6,
              backgroundColor: AppColor.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.h, color: AppColor.white),
                borderRadius: BorderRadius.circular(8.r),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: AppDimension.h20,
                color: AppColor.white,
              ),
              8.0.width,
              Text(title,
                  style: AppFont.semibold12.copyWith(color: AppColor.white))
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimension.w16),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buttonMenu(icon: Icons.arrow_downward, title: 'Deposit'),
        buttonMenu(icon: Icons.arrow_upward, title: 'Withdraw'),
        buttonMenu(icon: Icons.sync_alt, title: 'Trasnfer'),
      ]),
    );
  }
}
