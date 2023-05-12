import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/domain.dart';

class Wall extends StatelessWidget {
  const Wall({super.key, required this.controller, required this.tradingController});
  final HomeController controller;
  final TradingController tradingController;
  @override
  Widget build(BuildContext context) {
    Widget cardBuy(
        {required int index,
        dynamic bids,
        required HomeController controller,
        Function()? onClick}) {
      var rowWidth = 0.0;
      if (controller.bids != [] && controller.bids.isNotEmpty) {
        var resultData = MethodHelper.mapValues(
            controller.maxVolume.value, controller.orderBookEntryBids);

        rowWidth = resultData != null && resultData.length > 0
            ? resultData[index]['value'] / 100
            : 0.0;
      }
      return SizedBox(
        height: 19.h,
        child: Stack(children: [
          SizedBox.expand(
            child: RotatedBox(
              quarterTurns: 0,
              child: LinearProgressIndicator(
                value: rowWidth,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.greenBuy.withOpacity(0.2)),
              ),
            ),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    4.0.width,
                    Text(
                      NumberFormat.currency(
                        locale: 'id_ID',
                        symbol: '',
                        decimalDigits:
                            controller.selectedMarket.value.pricePrecision,
                      ).format(bids[0] != ''
                          ? double.parse(bids[0])
                          : double.parse('0')),
                      style: AppFont.reguler12.copyWith(
                          fontFamily: 'Roboto', color: AppColor.greenNotif),
                    ),
                  ],
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id_ID',
                    symbol: '',
                    decimalDigits:
                        controller.selectedMarket.value.amountPrecision!,
                  ).format(bids[1] != ''
                      ? double.parse(bids[1])
                      : double.parse('0')),
                  style: AppFont.reguler12
                      .copyWith(fontFamily: 'Roboto', color: AppColor.white),
                ),
              ],
            ),
          )
        ]),
      );
    }

    Widget cardSell({
      required int index,
      dynamic asks,
      required HomeController controller,
      Function()? onClick,
    }) {
      var rowWidth = 0.0;
      if (controller.asks != [] && controller.asks.isNotEmpty) {
        var resultData = MethodHelper.mapValues(
            controller.maxVolume.value, controller.orderBookEntryAsks);

        rowWidth = resultData != null && resultData.length > 0
            ? resultData[index]['value'] / 100
            : 0.0;
      }
      return SizedBox(
        height: 19.h,
        child: Stack(children: [
          SizedBox.expand(
            child: RotatedBox(
              quarterTurns: 2,
              child: LinearProgressIndicator(
                value: rowWidth,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.redSell.withOpacity(0.2)),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: '',
                          decimalDigits:
                              controller.selectedMarket.value.amountPrecision!)
                      .format(asks[1] != ''
                          ? double.parse(asks[1])
                          : double.parse('0')),
                  style: AppFont.reguler12
                      .copyWith(fontFamily: 'Roboto', color: AppColor.white),
                ),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(
                              locale: 'id_ID',
                              symbol: '',
                              decimalDigits: controller
                                  .selectedMarket.value.pricePrecision!)
                          .format(asks[0] != ''
                              ? double.parse(asks[0])
                              : double.parse('0')),
                      style: AppFont.reguler12.copyWith(
                          fontFamily: 'Roboto', color: AppColor.redNotif),
                    ),
                    4.0.width,
                  ],
                )
              ],
            ),
          )
        ]),
      );
    }

    Widget listBuyWall() {
      return SizedBox(
        height: 224.h,
        width: MediaQuery.of(context).size.width / 2 - AppDimension.w28,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Price",
                    style: AppFont.medium12.copyWith(color: AppColor.white)),
                Text("Amount",
                    style: AppFont.medium12.copyWith(color: AppColor.white)),
              ],
            ),
            4.0.height,
            Obx(() {
              return controller.bids.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(top: 1.w),
                          child: cardBuy(
                              index: index,
                              onClick: () {
                              tradingController.setBidFormPrice(
                                    controller.bids[index]);
                              },
                              controller: controller,
                              bids: controller.bids[index]),
                        ),
                        itemCount: controller.bids.length,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(top: 1.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 17.h,
                                  child: Text(
                                    '--',
                                    style: AppFont.medium10
                                        .copyWith(color: AppColor.greenBuy),
                                  ),
                                ),
                                SizedBox(
                                  height: 17.h,
                                  child: Text(
                                    '--',
                                    style: AppFont.medium10
                                        .copyWith(color: AppColor.white),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
            }),
          ],
        ),
      );
    }

    Widget listSelWall() {
      return SizedBox(
        height: 224.h,
        width: MediaQuery.of(context).size.width / 2 - AppDimension.w28,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Amount",
                    style: AppFont.medium14.copyWith(color: AppColor.white)),
                Text("Price",
                    style: AppFont.medium14.copyWith(color: AppColor.white)),
              ],
            ),
            4.0.height,
            Obx(() {
              return controller.asks.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(top: (index == 0) ? 0 : 1.w),
                          child: cardSell(
                            controller: controller,
                            index: index,
                            asks: controller.asks[index],
                            onClick: () {
                              tradingController.setAskFormPrice(controller.asks[index]);
                            },
                          ),
                        ),
                        itemCount: controller.asks.length,
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) => Padding(
                            padding:
                                EdgeInsets.only(top: (index == 0) ? 0 : 1.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 17.h,
                                  child: Text(
                                    '--',
                                    style: AppFont.medium10
                                        .copyWith(color: AppColor.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 17.h,
                                  child: Text(
                                    '--',
                                    style: AppFont.medium10
                                        .copyWith(color: AppColor.redSell),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
            }),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppDimension.h8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimension.w8),
          color: const Color(0xff282831),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.white12)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [listSelWall(), listBuyWall()],
      ),
    );
  }
}
