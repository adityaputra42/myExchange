import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/views/pages/trading/component/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/domain.dart';
import 'component/content.dart';

class TradingScreen extends StatelessWidget {
  TradingScreen({super.key});
  final TradingController controller = Get.put(TradingController());
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    appBar() {
      return AppBar(
        backgroundColor: const Color(0xff1d1b23),
        elevation: 1,
        shadowColor: Colors.white12,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: AppColor.white,
            size: AppDimension.h20,
          ),
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(
            controller.market.value.name ?? '',
            style: AppFont.semibold16.copyWith(color: AppColor.white),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.star_outline_rounded,
              color: AppColor.darkerGray,
              size: AppDimension.w22,
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color(0xff1d1b23),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimension.w16,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(children: [
              HeaderTrading(
                controller: controller,
              ),
              Content(
                controller: controller,
                homeController: homeController,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
