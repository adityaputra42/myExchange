import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/views/pages/trading/component/chart/chart.dart';
import 'package:crypto_app/views/pages/trading/component/order_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';

class Content extends StatelessWidget {
  const Content(
      {super.key, required this.controller, required this.homeController});
  final TradingController controller;
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.symmetric(vertical: AppDimension.),
      height: MediaQuery.of(context).size.height.h - 244.h,
      child: Obx(() {
        return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: AppDimension.h48,
                padding: EdgeInsets.all(AppDimension.h4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimension.w8),
                    color: const Color(0xff282831),
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 1, blurRadius: 1, color: Colors.white12)
                    ]),
                margin: EdgeInsets.only(bottom: AppDimension.h12),
                child: TabBar(
                  automaticIndicatorColorAdjustment: false,
                  indicator: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(AppDimension.h8)),
                  isScrollable: false,
                  indicatorColor: AppColor.white,
                  labelColor: AppColor.white,
                  labelPadding: EdgeInsets.zero,
                  labelStyle: AppFont.semibold14,
                  unselectedLabelColor: AppColor.darkerGray,
                  indicatorSize: TabBarIndicatorSize.tab,
                  onTap: (index) {
                    controller.changeIndex(index);
                  },
                  tabs: const [
                    Tab(
                      child: Text(
                        "Order Book",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Chart",
                      ),
                    ),
                  ],
                ),
              ),
              controller.selectedIndex.value == 0
                  ? OrderBook(
                      controller: homeController,
                    )
                  : Chart(
                      controller: controller,
                    )
              // TabBarView(children: [Wall()])
            ],
          ),
        );
      }),
    );
  }
}
