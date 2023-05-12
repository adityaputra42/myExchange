import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/views/pages/trading/component/input_transaction/tab_buy_sell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/domain.dart';
import 'button_buy_or_sell.dart';
import 'input_transaction.dart';

class TransactionInput extends StatelessWidget {
  TransactionInput({super.key});
  final TradingController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimension.w8),
            color: const Color(0xff282831),
            boxShadow: const [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.white12)
            ]),
        child: Obx(() {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: TabBarBuySell(
                  selectedIndex: controller.selectedBuySell.value,
                  onTap: (index) => controller.changeBuySell(index),
                ),
              ),
              16.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: InputTransaction(
                 
                  precision: controller.market.value.pricePrecision??0,
                  controller: controller.priceController,
                  onChanged:  controller.onPriceChange,
                  textInputAction: TextInputAction.next,
                  // focusNode: controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyPriceFocusNode
                  //     : controller.limitSellPriceFocusNode,
                  // onEditingConmplete: () => controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyPriceFocusNode.requestFocus()
                  //     : controller.limitSellPriceFocusNode.requestFocus(),

                
                 
                  hint: "Price",
                  
                ),
              ),
              8.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: InputTransaction(
                  controller: controller.amountController,
                  precision: controller.market.value.amountPrecision??0,
                  onChanged:controller.onAmountChange,
                  textInputAction: TextInputAction.done,
                  // focusNode: controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyAmountFocusNode
                  //     : controller.limitSellAmountFocusNode,
                  // onEditingConmplete: () => controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyAmountFocusNode.requestFocus()
                  //     : controller.limitSellAmountFocusNode.requestFocus(),
                
                 
                  hint: 'amount'.tr,
                  
                ),
              ),
              16.0.height,
              SizedBox(
                height: AppDimension.h12,
                child: Slider(
                  value: 
                   controller.selectedBuySell.value == 0
                      ? controller.sliderBuy.value
                      : controller.sliderSell.value,
                  max: 100,
                  divisions: 10,
                  activeColor: AppColor.primaryColor,
                  inactiveColor: AppColor.gray,
                  label: "${(controller.selectedBuySell.value == 0
                      ? controller.sliderBuy.value.round()
                      : controller.sliderSell.value.round())}%",
                  onChanged: (double value) {
                    controller.setSliderPercent(
                        value: value,
                    );
                  },
                ),
              ),
              16.0.height,
              // }),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Estimate Price",
                        style: AppFont.medium12
                            .copyWith(color: AppColor.darkerGray)
                       
                        ),
                    Text(
                      "${NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: '').format(controller.totalPrice.value)} ${(controller.market.value.quoteUnit??'').toUpperCase()}",
                   
                      style: AppFont.medium12.copyWith(
                          fontSize: 13.sp,
                          fontFamily: "Roboto",
                          color: AppColor.white),
                    ),
                  ],
                ),
              ),
              4.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Available Balance",
                       
                        style: AppFont.medium12
                            .copyWith(color: AppColor.darkerGray)),
                    Text(
                      "${NumberFormat.currency(locale: "en_US", decimalDigits: 
                          controller.selectedBuySell.value == 0
                              ? controller.market.value.pricePrecision??0
                              : controller.market.value.amountPrecision??0,
                          symbol: '') .format(controller.selectedBuySell.value == 0
                          ? (roundDouble(
                              controller.balanceQuote.value,
                              controller.market.value.pricePrecision??0))
                          : (roundDouble(
                              controller.balanceBase.value,
                              controller.market.value.amountPrecision??0)))} ${controller.selectedBuySell.value == 0 ? (controller.market.value.quoteUnit??"").toUpperCase() : (controller.market.value.baseUnit??"").toUpperCase()}"
                     ,
                      style: AppFont.medium12.copyWith(
                          fontSize: 13.sp,
                          fontFamily: "Roboto",
                          color: AppColor.white),
                    )
                  ],
                ),
              ),
              16.0.height,
              ButtonBuyOrSell(
                  height: 40.h,
                  margin: EdgeInsets.only(
                      left: AppDimension.w8, right: AppDimension.w8),
                  title:
                      (controller.selectedBuySell.value == 0) ? 'Buy' : 'Sell',
                  isBuy: (controller.selectedBuySell.value == 0) ? true : false,
                  onPressed: () {
                    // Get.toNamed('/login');
                  }),
            
            ],
          );
        }));
  }

}
