import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../trading/trading_screen.dart';

class SliderMarket extends StatelessWidget {
  const SliderMarket({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    Widget cardSlider(FormatedMarket market) {
      List<FlSpot> lineSpot = [];

      for (final value in market.kline ?? []) {
        lineSpot.add(FlSpot(value[0].toDouble(), value[2].toDouble()));
      }
      return GestureDetector(
        onTap: () {
          controller.setMarket(market);
          Get.to(() => TradingScreen())!
              .then((value) => Get.delete<TradingController>());
        },
        child: Container(
          height: 130.h,
          width: MediaQuery.of(context).size.width*0.29,
          padding: EdgeInsets.all(6.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(spreadRadius: 0.7, blurRadius: 0.5,offset: Offset(0.5, 0.5), color: Colors.white10)
              ],
              color: const Color(0xff282831)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 26.h,
                    height: 26.h,
                    // padding: EdgeInsets.all(1.5.h),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.white),
                    child: (market.iconUrl != null)
                        ? (market.iconUrl!.contains('.svg')
                            ? Image(
                                image: Svg(market.iconUrl!,
                                    source: SvgSource.network))
                            : Image(
                                image: CachedNetworkImageProvider(
                                    market.iconUrl!)))
                        : Image.asset(AppImage.btc),
                  ),
                  6.0.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(market.name!.toUpperCase(),
                          style:
                              AppFont.medium10.copyWith(color: AppColor.white)),
                      Text(market.currencyName!.capitalize!,
                          style: AppFont.reguler10
                              .copyWith(color: AppColor.darkerGray, fontSize: 9.sp)),
                    ],
                  ),
                ],
              ),
              16.0.height,
              Expanded(
                child: LineChart(LineChartData(
                  gridData: FlGridData(
                    show: false,
                  ),
                  titlesData: FlTitlesData(
                    show: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: lineSpot,
                      // spots: lineSpot,
                      isCurved: false,
                      color: (market.priceChangePercent!).contains('+')
                          ? AppColor.greenBuy
                          : AppColor.redSell,
                      barWidth: 2,
                      isStrokeCapRound: false,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            (market.priceChangePercent!).contains('+')
                                ? AppColor.greenBuy
                                : AppColor.redSell,
                            const Color(0xff282831)
                            // Theme.of(context).cardColor
                          ],
                          // .map((color) => color.withOpacity(0.6)).toList(),
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "\$${NumberFormat.currency(locale: "en_US", decimalDigits: market.pricePrecision!, symbol: '').format(market.last)}",
                      style: AppFont.medium10.copyWith(
                          fontFamily: "Roboto", color: AppColor.white)),
                  Text(market.priceChangePercent!,
                      style: AppFont.medium10.copyWith(
                        fontFamily: "Roboto",
                        color: (market.priceChangePercent!).contains('+')
                            ? AppColor.greenBuy
                            : AppColor.redSell,
                      )),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget shimmerLoading() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimension.w16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Shimmer.fromColors(
                  baseColor: AppColor.darkerGray,
                  highlightColor: AppColor.white,
                  child: Container(
                     height: 130.h,
          width: MediaQuery.of(context).size.width*0.29,
                    color: AppColor.darkerGray,
                  ),
                ),
              ),
            ),
            
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Shimmer.fromColors(
                  baseColor: AppColor.darkerGray,
                  highlightColor: AppColor.white,
                  child: Container(
                           height: 130.h,
          width: MediaQuery.of(context).size.width*0.29,
                    color: AppColor.darkerGray,
                  ),
                ),
              ),
            ),
           Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Shimmer.fromColors(
                  baseColor: AppColor.darkerGray,
                  highlightColor: AppColor.white,
                  child: Container(
                          height: 130.h,
          width: MediaQuery.of(context).size.width*0.29,
                    color: AppColor.darkerGray,
                  ),
                ),
              ),
            ),
           
          ],
        ),
      );
    }

    return Obx(() {
      return (controller.isLoading.value)
          ? shimmerLoading()
          : CarouselSlider(
              items: [
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 1.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: controller.formatedMarketsList
                    .map((e) => cardSlider(e))
                    .toList()
                    .sublist(0, 3)
                    .toList(),),
              ),
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 1.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: controller.formatedMarketsList
                    .map((e) => cardSlider(e))
                    .toList()
                    .sublist(3, 6)
                    .toList(),),
              ),Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 1.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: controller.formatedMarketsList
                    .map((e) => cardSlider(e))
                    .toList()
                    .sublist(6, 9)
                    .toList(),),
              )
              ],
              options: CarouselOptions(
                aspectRatio: 1 / 1,
                height: 132.h,
                viewportFraction: 1,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                enlargeCenterPage: true,
                autoPlay: true,
                initialPage: 0,
              ));
    });
  }
}
