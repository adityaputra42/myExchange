import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../config/config.dart';

class HeaderTrading extends StatelessWidget {
  const HeaderTrading({super.key, required this.controller});
  final TradingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppDimension.h12, bottom: AppDimension.h12),
      padding: EdgeInsets.symmetric(
          horizontal: AppDimension.w8, vertical: AppDimension.h12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimension.w8),
          color: const Color(0xff282831),
          boxShadow: const [
            BoxShadow(spreadRadius: 0.5, blurRadius: 0.5, color: Colors.white12)
          ]),
      child: 
      Obx(() {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NumberFormat.currency(
                          locale: "en_US",
                          decimalDigits: controller.market.value.pricePrecision,
                          symbol: "")
                      .format(
                    controller.market.value.last ?? 0,
                  ),
                  style: AppFont.semibold18.copyWith(
                      fontSize: 20.sp,
                      fontFamily: "Roboto",
                      color: (controller.market.value.priceChangePercent ?? '')
                              .contains('+')
                          ? AppColor.greenBuy
                          : AppColor.redSell),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        NumberFormat.currency(
                                locale: "en_US",
                                decimalDigits:
                                    controller.market.value.pricePrecision ?? 0,
                                symbol: "")
                            .format((controller.market.value.last??0) -
                               ( controller.market.value.open??0)),
                        style: AppFont.reguler12.copyWith(
                            fontSize: 13.sp,
                            fontFamily: "Roboto",
                            color: AppColor.white)),
                    8.0.width,
                    Container(
                      height: 18.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: (controller.market.value.priceChangePercent?? "")
                                  .contains('+')
                              ? AppColor.greenBuy
                              : AppColor.redSell),
                      child: Center(
                        child: Text(
                          controller.market.value.priceChangePercent??"",
                          style:
                              AppFont.medium10.copyWith(color: AppColor.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2 - AppDimension.w32,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '24h High',
                        style: AppFont.reguler10
                            .copyWith(color: AppColor.darkerGray),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: "en_US",
                                decimalDigits:
                                    controller.market.value.pricePrecision,
                                symbol: "")
                            .format(controller.market.value.high??0),
                        style:
                            AppFont.reguler10.copyWith(color: AppColor.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '24h Low',
                        style: AppFont.reguler10
                            .copyWith(color: AppColor.darkerGray),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: "en_US",
                                decimalDigits:
                                    controller.market.value.pricePrecision,
                                symbol: "")
                            .format(
                          controller.market.value.low??0,
                        ),
                        style:
                            AppFont.reguler10.copyWith(color: AppColor.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '24h Volume',
                        style: AppFont.reguler10
                            .copyWith(color: AppColor.darkerGray),
                      ),
                      Text(
                        NumberFormat.currency(
                                locale: "en_US",
                                decimalDigits:
                                    controller.market.value.pricePrecision,
                                symbol: "")
                            .format(
                          controller.market.value.volume??0,
                        ),
                        style:
                            AppFont.reguler10.copyWith(color: AppColor.white),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
