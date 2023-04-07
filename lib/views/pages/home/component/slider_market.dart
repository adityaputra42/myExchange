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
          width: 180.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.white12)
              ],
              color: const Color(0xff282831)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    padding: EdgeInsets.all(2.h),
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
                  8.0.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(market.name!.toUpperCase(),
                          style:
                              AppFont.medium12.copyWith(color: AppColor.white)),
                      Text(market.currencyName!.toUpperCase(),
                          style: AppFont.reguler10
                              .copyWith(color: AppColor.darkerGray)),
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
                      style: AppFont.medium12.copyWith(
                          fontFamily: "Roboto", color: AppColor.white)),
                  Text(market.priceChangePercent!,
                      style: AppFont.medium12.copyWith(
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
                  baseColor: AppColor.gray,
                  highlightColor: AppColor.white,
                  child: Container(
                    height: 132.h,
                    width: 109.w,
                    color: AppColor.gray,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Shimmer.fromColors(
                  baseColor: AppColor.gray,
                  highlightColor: AppColor.white,
                  child: Container(
                    height: 132.h,
                    width: 109.w,
                    color: AppColor.gray,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Shimmer.fromColors(
                  baseColor: AppColor.gray,
                  highlightColor: AppColor.white,
                  child: Container(
                    height: 132.h,
                    width: 109.w,
                    color: AppColor.gray,
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
              items: controller.formatedMarketsList
                  .map((e) => cardSlider(e))
                  .toList()
                  .sublist(0, 6)
                  .toList(),
              options: CarouselOptions(
                aspectRatio: 1 / 1,
                height: 134.h,
                viewportFraction: 0.48,
                autoPlayInterval: const Duration(seconds: 6),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                enlargeCenterPage: true,
                autoPlay: true,
                initialPage: 0,
              ));
    });
  }
}
