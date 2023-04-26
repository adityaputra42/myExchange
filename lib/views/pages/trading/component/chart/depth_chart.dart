import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../../../../config/config.dart';

class DepthChartPage extends StatelessWidget {
  const DepthChartPage({super.key, required this.controller});
  final TradingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.33,
      width: double.infinity,
      padding: EdgeInsets.all(AppDimension.h8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimension.w8),
          color: const Color(0xff282831),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.white12)
          ]),
      child: Obx(() {
        return Stack(
          children: [
            DepthChart(
                fixedLength: controller.market.value.amountPrecision!,
                buyPathColor: AppColor.greenBuy.withOpacity(0.25),
                sellPathColor: AppColor.redSell.withOpacity(0.25),
                controller.bidsData,
                controller.asksData,
                ChartColors()),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dotBidAsk(
                      color: AppColor.greenBuy.withOpacity(1), title: "Bid"),
                  SizedBox(
                    width: 5.sp,
                  ),
                  _dotBidAsk(
                      color: AppColor.redSell.withOpacity(1), title: "Ask"),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  Row _dotBidAsk({Color? color, String? title}) {
    return Row(
      children: [
        Container(
          height: 10.sp,
          width: 10.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: color ?? AppColor.redSell.withOpacity(1),
          ),
        ),
        4.0.width,
        Text(title ?? "Ask",
            style: AppFont.medium12.copyWith(color: AppColor.white)),
      ],
    );
  }
}
