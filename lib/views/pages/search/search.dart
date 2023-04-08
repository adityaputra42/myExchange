import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/controller/search_contoller.dart';
import 'package:crypto_app/domain/domain.dart';
import 'package:crypto_app/utils/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../trading/trading_screen.dart';

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
final SearchController controller = Get.put(SearchController());
final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardSearchMarket(FormatedMarket market) {
      return GestureDetector(onTap: () {
          homeController.setMarket(market);
          Get.to(() => TradingScreen())!
              .then((value) => Get.delete<TradingController>());
      },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: const Color(0xff282831),
              boxShadow: const [
                BoxShadow(
                    spreadRadius: 0.7,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1,
                    color: Colors.white12)
              ]),
          child: Row(
            children: [
              Container(
                        height: 36.w,
                        width: 36.w,
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
              8.0.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (market.name??"").toUpperCase(),
                      style: AppFont.medium14.copyWith(color: AppColor.white),
                    ),
                    Text(
                   ( market.currencyName??"").capitalize!,
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.darkerGray),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.currency(
                            symbol: "\$ ", decimalDigits: market.pricePrecision, locale: "id_ID")
                        .format(market.last),
                    style: AppFont.medium14.copyWith(color: AppColor.white),
                  ),
                  Row(
                    children: [
                     ( market.priceChangePercent??"").contains("+")? Icon(
                        Icons.trending_up_rounded,
                        color: AppColor.greenBuy,
                        size: 16.w,
                      ):Icon(
                        Icons.trending_down_rounded,
                        color: AppColor.redSell,
                        size: 16.w,
                      ),
                      4.0.width,
                      Text(
                      market.priceChangePercent??"",
                        style:
                            AppFont.reguler12.copyWith(color:( market.priceChangePercent??"").contains("+")? AppColor.greenBuy:AppColor.redSell),
                      ),
                    ],
                  ),
                ],
              ),
              4.0.width
            ],
          ),
        ),
      );
    }

    appBar() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.25,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 22.h,
                  )),
              8.0.width,
              Expanded(
                child: SizedBox(
                  height: 42.h,
                  child: TextFormField(
                    controller: controller.searchTextController,
                    onChanged: controller.searchMarket,
                    textAlignVertical: TextAlignVertical.center,
                    style: AppFont.medium14.copyWith(color: AppColor.white),
                    decoration: InputDecoration(
                      suffixIconColor: AppColor.darkerGray,
                      suffixIcon: Icon(
                        Icons.search,
                        size: 20.w,
                      ),
                      fillColor: const Color(0xff3c3c43),
                      filled: true,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          width: 1,
                          color: AppColor.errorRed,
                        ),
                      ),
                      hintText: "Search Market",
                      hintStyle:
                          AppFont.light12.copyWith(color: AppColor.darkerGray),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        borderSide:
                            BorderSide(width: 1.h, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        borderSide:
                            BorderSide(width: 1.h, color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        borderSide: BorderSide(
                            width: 1.h, color: AppColor.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xff282831),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff1D1B23),
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.0.height,
            Text(
              "Trending Market",
              style: AppFont.medium16.copyWith(color: AppColor.white),
            ),
            8.0.height,
            Obx(
             (){
                return Expanded(
                  child: controller.foundMarket.isEmpty? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset(AppImage.empty,width: 120.w,),16.0.height, Text("Not Found", style: AppFont.medium14.copyWith(color: AppColor.white),)],),): ListView.builder(
                      itemCount: controller.foundMarket.length,physics:const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(top: 12.h),
                            child: cardSearchMarket(controller.foundMarket[index]),
                          )),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
