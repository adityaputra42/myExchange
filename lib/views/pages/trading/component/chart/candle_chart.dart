import 'package:candlestick_digiasset/candlestick_digiasset.dart';
import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/config.dart';

class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.controller});
  final TradingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      width: double.infinity,
      padding: EdgeInsets.all(AppDimension.h8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimension.w8),
          color: const Color(0xff282831),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.white12)
          ]),
      child: Obx(() {
        return Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                              controller.initialLineGraphTimeSlots.map((slot) {
                            return GestureDetector(
                              onTap: () {
                                controller.dropdownShown.value = false;
                                controller.updateKlineTimeOption(slot);
                              },
                              child: Row(children: [
                                Text(
                                  slot['key'].toString(),
                                  style: TextStyle(
                                      fontFamily: 'Popins',
                                      fontSize: 12,
                                      color: controller.selectedOption['key'] ==
                                              slot['key']
                                          ? AppColor.primaryColor
                                          : AppColor.darkerGray,
                                      fontWeight:
                                          controller.selectedOption['key'] ==
                                                  slot['key']
                                              ? FontWeight.w900
                                              : FontWeight.w500),
                                ),
                              ]),
                            );
                          }).toList()),
                    ),
                  ),
                  12.0.width,
                  GestureDetector(
                      onTap: () {
                        // Get.to(() => CandleFullPage(controller: controller))!
                        //     .then(
                        //         (value) => SystemChrome.setPreferredOrientations([
                        //               DeviceOrientation.portraitUp,
                        //               DeviceOrientation.portraitDown,
                        //             ]));
                      },
                      child: Icon(
                        Icons.zoom_in_map_rounded,
                        size: AppDimension.h22,
                        color: AppColor.white,
                      )),
                  SizedBox(
                    width: AppDimension.w10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220.h,
              child: controller.isKLineLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Candlesticks(
                      highLowTextColor: AppColor.white,
                      decimalDigits:
                          controller.market.value.pricePrecision ?? 0,
                      watermark: "Digiasset",
                      candleStyle: CandleStyle(
                          textHighLowColor: AppColor.white,
                          bearColor: AppColor.redSell,
                          bullColor: AppColor.greenBuy),
                      style: CandleSticksStyle.dark(
                          background: const Color(0xff282831),
                          primaryBull: AppColor.greenBuy,
                          primaryBear: AppColor.redSell,
                          secondaryBear: AppColor.redSell,
                          secondaryBull: AppColor.greenBuy,
                          toolBarColor: AppColor.primaryColor),
                      // candleStyle: CandleStyle(s),
                      ma25: false,
                      ma99: false,
                      ma7: false,
                      candles: controller.candles.reversed.toList(),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
