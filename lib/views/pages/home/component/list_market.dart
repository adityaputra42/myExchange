import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/views/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../trading/trading_screen.dart';

class ListMarket extends StatelessWidget {
  const ListMarket({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    Widget cardMarket(FormatedMarket market) {
      return GestureDetector(
        onTap: () {
          controller.setMarket(market);
          Get.to(() => TradingScreen())!
              .then((value) => Get.delete<TradingController>());
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: 44.w,
                      width: 44.w,
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.all(4.h),
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
                          : Image.asset(AppImage.btc)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(market.name!.toUpperCase(),
                          style:
                              AppFont.medium14.copyWith(color: AppColor.white)),
                      1.0.height,
                      Text(market.currencyName!,
                          style: AppFont.reguler12
                              .copyWith(color: AppColor.darkerGray)),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.43,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            NumberFormat.currency(
                                    symbol: '',
                                    locale: 'id_ID',
                                    decimalDigits: market.pricePrecision)
                                .format(market.last),
                            style: AppFont.medium14.copyWith(
                              color: (market.priceChangePercent ?? "").contains('+')
                              ? AppColor.greenBuy
                              : AppColor.redSell),
                            ),
                        1.0.height,
                        Text(
                          "Vol24H : ${NumberFormat.compact(
                            locale: 'en_US',
                          ).format(market.volume)}",
                          style: AppFont.reguler12.copyWith(
                            color: AppColor.darkerGray,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 64.w,
                      height: AppDimension.h36,
                      margin: EdgeInsets.only(left: 16.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (market.priceChangePercent ?? "").contains('+')
                              ? AppColor.greenBuy
                              : AppColor.redSell),
                      child: Center(
                        child: Text(market.priceChangePercent!,
                            style: AppFont.medium12.copyWith(
                              fontFamily: "Roboto",
                              color: AppColor.white,
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget shimmerLoading() {
      return ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Shimmer.fromColors(
                baseColor: AppColor.gray,
                highlightColor: AppColor.white,
                child: Container(
                  height: 64.h,
                  width: double.infinity,
                  color: AppColor.gray,
                ),
              ),
            ),
          );
        },
      );
    }

    Widget gainers() {
      return Obx(() {
        return controller.isLoading.value
            ? shimmerLoading()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: controller.gainers.reversed
                        .map((e) => cardMarket(e))
                        .toList()
                        .sublist(0, 6)
                        .toList()),
              );
      });
    }

    Widget losser() {
      return Obx(() {
        return controller.isLoading.value
            ? shimmerLoading()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: controller.losers
                        .map((e) => cardMarket(e))
                        .toList()
                        .sublist(0, 6)
                        .toList()),
              );
      });
    }

    Widget topVolume() {
      return Obx(() {
        return controller.isLoading.value
            ? shimmerLoading()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    children: controller.volume.reversed
                        .map((e) => cardMarket(e))
                        .toList()
                        .sublist(0, 6)
                        .toList()),
              );
      });
    }

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTabBar(
            titles: const ["Gainers", "Lossers", "Top Volume"],
            selectedIndex: controller.tabBarIndex.value,
            onTap: (index) {
              controller.setTabBarIndex(index);
            },
          ),
          16.0.height,
          controller.tabBarIndex.value == 0
              ? gainers()
              : controller.tabBarIndex.value == 1
                  ? losser()
                  : topVolume()
        ],
      );
    });
  }
}
