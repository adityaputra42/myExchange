import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buttonMenu({required IconData icon, required String title}) {
      return Column(
        children: [
          Container(
            width: 36.h,height: 36.h,
            decoration:const BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [AppColor.secondaryColor,AppColor.primaryColor, ])),
           
              child: Center(
                child: Icon(
                  icon,
                  
                  color: AppColor.white,
                ),
              // ),
            ),
          ), 
          4.0.height, 
          Text(title,
                  style: AppFont.semibold12.copyWith(color: AppColor.white))
        ],
      );
    }

    return Container(margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 12.w),
      decoration: BoxDecoration(color:const Color(0xff1d1b23), borderRadius: 
      BorderRadius.circular(16.r),
      boxShadow: [BoxShadow(blurRadius: 0.5.h,spreadRadius: 0.5, offset: Offset(0.1.h, 0.2.h), color: Colors.white10)]
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        buttonMenu(icon: Icons.arrow_downward, title: 'Deposit'),
        buttonMenu(icon: Icons.arrow_upward, title: 'Withdraw'),
        buttonMenu(icon: Icons.sync_alt, title: 'Trasnfer'),
         buttonMenu(icon: Icons.more_vert_rounded, title: 'More'),
      ]),
    );
  }
}
