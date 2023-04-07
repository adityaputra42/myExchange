import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../config/config.dart';

class ButtonBuyOrSell extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final bool isBuy;
  final Function() onPressed;
  final EdgeInsets margin;

  const ButtonBuyOrSell({
    Key? key,
    required this.title,
    this.height = 36,
    this.isBuy = true,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 36.h,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: isBuy ? AppColor.greenNotif : AppColor.redSell,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r))),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppFont.semibold14.copyWith(color: AppColor.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
