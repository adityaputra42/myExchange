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
                  controller: TextEditingController(),
                  // precision: market.pricePrecision,
                  // controller: controller.selectedTabbar.value == 0
                  //     ? controller.limitOrderBuyPriceTextController
                  //     : controller.limitOrderSellPriceTextController,
                  // onChanged: controller.selectedTabbar.value == 0
                  //     ? controller.onLimitOrderBuyPriceChange
                  //     : controller.onLimitOrderSellPriceChange,
                  // textInputAction: TextInputAction.next,
                  // focusNode: controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyPriceFocusNode
                  //     : controller.limitSellPriceFocusNode,
                  // onEditingConmplete: () => controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyPriceFocusNode.requestFocus()
                  //     : controller.limitSellPriceFocusNode.requestFocus(),

                  // ontap: () {
                  //   controller.activeKeyboard();
                  //   controller.setInPrice(true);
                  // },
                  // onChange: (value) => _checkvalue(value),
                  kurangData: () {
                    // removeValueFromInput(
                    // context,
                    // controller.selectedTabbar.value == 0 ? 'buy' : 'sell',
                    // 'price',
                    // market.pricePrecision!);
                  },
                  hint: "Price",
                  tambahData: () {
                    // addValueToInput(
                    //     context,
                    //     controller.selectedTabbar.value == 0 ? 'buy' : 'sell',
                    //     'price',
                    //     market.pricePrecision!);
                  },
                ),
              ),
              8.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimension.w8),
                child: InputTransaction(
                  controller: TextEditingController(),
                  // precision: market.amountPrecision,
                  // controller: controller.selectedTabbar.value == 0
                  //     ? controller.limitOrderBuyAmountTextController
                  //     : controller.limitOrderSellAmountTextController,
                  // onChanged: controller.selectedTabbar.value == 0
                  //     ? controller.onLimitOrderBuyAmountChange
                  //     : controller.onLimitOrderSellAmountChange,
                  // textInputAction: TextInputAction.done,
                  // focusNode: controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyAmountFocusNode
                  //     : controller.limitSellAmountFocusNode,
                  // onEditingConmplete: () => controller.selectedTabbar.value == 0
                  //     ? controller.limitBuyAmountFocusNode.requestFocus()
                  //     : controller.limitSellAmountFocusNode.requestFocus(),
                  // ontap: () {
                  //   controller.activeKeyboard();
                  //   controller.setInPrice(false);
                  // },
                  kurangData: () {
                    // removeValueFromInput(
                    //     context,
                    //     controller.selectedTabbar.value == 0 ? 'buy' : 'sell',
                    //     'amount',
                    //     market.amountPrecision!);
                  },
                  hint: 'amount'.tr,
                  tambahData: () {
                    // addValueToInput(
                    //     context,
                    //     controller.selectedTabbar.value == 0 ? 'buy' : 'sell',
                    //     'amount',
                    //     market.amountPrecision!);
                  },
                ),
              ),
              16.0.height,
              SizedBox(
                height: AppDimension.h12,
                child: Slider(
                  value: 0,
                  //  controller.selectedTabbar.value == 0
                  //     ? controller.sliderLimitBuy.value
                  //     : controller.sliderLimitSell.value,
                  max: 100,
                  divisions: 10,
                  activeColor: AppColor.primaryColor,
                  inactiveColor: AppColor.gray,
                  // label: controller.selectedTabbar.value == 0
                  //     ? controller.sliderLimitBuy.value.round().toString()
                  //     : controller.sliderLimitSell.value.round().toString(),
                  onChanged: (double value) {
                    // controller.setSliderPercent(
                    //     value: value,
                    //     amounPrecision: market.amountPrecision,
                    //     pricePrecision: market.pricePrecision);
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
                        // " ${market.quoteUnit!}".toUpperCase(),
                        style: AppFont.medium12
                            .copyWith(color: AppColor.darkerGray)
                        // .copyWith(color: Theme.of(context).indicatorColor),
                        ),
                    Text(
                      "${NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: '').format(120)} IDR",
                      // format(controller.selectedTabbar.value == 0
                      //     ? controller.totalbuyLimit.value
                      //     : controller.totalSellLimit.value),
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
                        // " ${controller.selectedTabbar.value == 0 ? market.quoteUnit!.toUpperCase() : market.baseUnit!.toUpperCase()} ${"available".tr}",
                        style: AppFont.medium12
                            .copyWith(color: AppColor.darkerGray)),
                    Text(
                      "${NumberFormat.currency(locale: "en_US", decimalDigits: 0,
                          // controller.selectedTabbar.value == 0
                          //     ? market.pricePrecision!
                          //     : market.amountPrecision!,
                          symbol: '').format(123023)} IDR",
                      // .format(controller.selectedTabbar.value == 0
                      //     ? (roundDouble(
                      //         controller.walletQuote.value.balance ?? 0,
                      //         market.pricePrecision!))
                      //     : (roundDouble(
                      //         controller.walletBase.value.balance ?? 0,
                      //         market.amountPrecision!))),
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
              // (!homeController.isLoggedIn.value)
              //     ? ButtonBuyOrSell(
              //         title: 'Login',
              //         margin: EdgeInsets.symmetric(horizontal: AppDimension.w16),
              //         isBuy: (controller.selectedTabbar.value == 0) ? true : false,
              //         onPressed: () {
              //           Get.toNamed('/login');
              //         })
              //     : (controller.selectedTabbar.value == 0
              //             ? controller.isValidateLimitBuy.value
              //             : controller.isValidateLimitSell.value)
              //         ? ButtonBuyOrSell(
              //             title: (controller.selectedTabbar.value == 0)
              //                 ? "buy".tr
              //                 : "sell".tr,
              //             onPressed: () {
              //               if (homeController.user.value.level! <
              //                   homeController.publicMemberLevel.value.trading!
              //                       .minimumLevel!) {
              //                 showDialog(
              //                     barrierDismissible: false,
              //                     context: context,
              //                     builder: (context) => AlertVerify(
              //                           controller: homeController,
              //                         ));
              //               } else {
              //                 showDialog(
              //                     barrierDismissible: false,
              //                     context: context,
              //                     builder: (context) => AlertConfirmOrder(
              //                         market: market,
              //                         balance: (controller.selectedTabbar.value == 0)
              //                             ? controller.walletQuote.value.balance!
              //                             : controller.walletBase.value.balance!,
              //                         orderType: "Limit",
              //                         originVolume: (controller.selectedTabbar.value == 0)
              //                             ? double.parse(controller
              //                                 .limitOrderBuyAmountTextController
              //                                 .text)
              //                             : double.parse(controller
              //                                 .limitOrderSellAmountTextController
              //                                 .text),
              //                         price: (controller.selectedTabbar.value == 0)
              //                             ? double.parse(controller
              //                                 .limitOrderBuyPriceTextController
              //                                 .text)
              //                             : double.parse(
              //                                 controller.limitOrderSellPriceTextController.text),
              //                         side: (controller.selectedTabbar.value == 0) ? "buy" : "sell"));
              //               }
              //             },
              //             margin:
              //                 EdgeInsets.symmetric(horizontal: AppDimension.w16),
              //             isBuy:
              //                 (controller.selectedTabbar.value == 0) ? true : false,
              //           )
              //         : DisableBuySellButton(
              //             margin:
              //                 EdgeInsets.symmetric(horizontal: AppDimension.w16),
              //             isBuy:
              //                 (controller.selectedTabbar.value == 0) ? true : false,
              //             title: (controller.selectedTabbar.value == 0)
              //                 ? "buy".tr
              //                 : "sell".tr,
              //             onPressed: () {
              //               print(controller.isValidateLimitBuy.value);
              //             }),
            ],
          );
        }));
  }

  // void addValueToInput(
  //     BuildContext context, String formType, String inputType, int percision) {
  //   FocusScope.of(context).unfocus();
  //   var number = 1;
  //   var decimalPointNumber = number.toString().padRight(percision + 1, '0');
  //   var maxNumber = int.parse(decimalPointNumber);
  //   var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
  //   if (formType == 'buy' && inputType == 'price') {
  //     var existingNumber =
  //         controller.limitOrderBuyPriceTextController.text != ''
  //             ? double.parse(controller.limitOrderBuyPriceTextController.text)
  //             : 0.0;

  //     controller.limitOrderBuyPriceTextController.text =
  //         (existingNumber + double.parse(finalNumber))
  //             .toStringAsFixed(percision);
  //     controller.onLimitOrderBuyPriceChange(
  //         controller.limitOrderBuyPriceTextController.text);
  //   }
  //   if (formType == 'buy' && inputType == 'amount') {
  //     var existingNumber =
  //         controller.limitOrderBuyAmountTextController.text != ''
  //             ? double.parse(controller.limitOrderBuyAmountTextController.text)
  //             : 0.0;

  //     controller.limitOrderBuyAmountTextController.text =
  //         (existingNumber + double.parse(finalNumber))
  //             .toStringAsFixed(percision);
  //     controller.onLimitOrderBuyAmountChange(
  //         controller.limitOrderBuyAmountTextController.text);
  //   }
  //   if (formType == 'sell' && inputType == 'price') {
  //     var existingNumber =
  //         controller.limitOrderSellPriceTextController.text != ''
  //             ? double.parse(controller.limitOrderSellPriceTextController.text)
  //             : 0.0;

  //     controller.limitOrderSellPriceTextController.text =
  //         (existingNumber + double.parse(finalNumber))
  //             .toStringAsFixed(percision);
  //     controller.onLimitOrderSellPriceChange(
  //         controller.limitOrderSellPriceTextController.text);
  //   }
  //   if (formType == 'sell' && inputType == 'amount') {
  //     var existingNumber =
  //         controller.limitOrderSellAmountTextController.text != ''
  //             ? double.parse(controller.limitOrderSellAmountTextController.text)
  //             : 0.0;

  //     controller.limitOrderSellAmountTextController.text =
  //         (existingNumber + double.parse(finalNumber))
  //             .toStringAsFixed(percision);
  //     controller.onLimitOrderSellAmountChange(
  //         controller.limitOrderSellAmountTextController.text);
  //   }
  // }

  // void removeValueFromInput(
  //     BuildContext context, String formType, String inputType, int percision) {
  //   FocusScope.of(context).unfocus();
  //   var number = 1;
  //   var decimalPointNumber = number.toString().padRight(percision + 1, '0');
  //   var maxNumber = int.parse(decimalPointNumber);
  //   var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
  //   if (formType == 'buy' && inputType == 'price') {
  //     var existingNumber =
  //         controller.limitOrderBuyPriceTextController.text != ''
  //             ? double.parse(controller.limitOrderBuyPriceTextController.text)
  //             : 0.0;

  //     if (existingNumber > 0) {
  //       var removedFinalAmount = (existingNumber - double.parse(finalNumber));

  //       controller.limitOrderBuyPriceTextController.text =
  //           removedFinalAmount == 0
  //               ? ''
  //               : removedFinalAmount.toStringAsFixed(percision);
  //       controller.onLimitOrderBuyPriceChange(
  //           controller.limitOrderBuyPriceTextController.text);
  //     }
  //   }
  //   if (formType == 'buy' && inputType == 'amount') {
  //     var existingNumber =
  //         controller.limitOrderBuyAmountTextController.text != ''
  //             ? double.parse(controller.limitOrderBuyAmountTextController.text)
  //             : 0.0;

  //     if (existingNumber > 0) {
  //       var removedFinalAmount = (existingNumber - double.parse(finalNumber));
  //       controller.limitOrderBuyAmountTextController.text =
  //           removedFinalAmount == 0
  //               ? ''
  //               : removedFinalAmount.toStringAsFixed(percision);
  //       controller.onLimitOrderBuyAmountChange(
  //           controller.limitOrderBuyAmountTextController.text);

  //       // controller.limitOrderBuyAmountTextController.text =
  //       //     (existingNumber - double.parse(finalNumber))
  //       //         .toStringAsFixed(percision);
  //       // controller.onLimitOrderBuyAmountChange(
  //       //     controller.limitOrderBuyAmountTextController.text);
  //     }
  //   }
  //   if (formType == 'sell' && inputType == 'price') {
  //     var existingNumber =
  //         controller.limitOrderSellPriceTextController.text != ''
  //             ? double.parse(controller.limitOrderSellPriceTextController.text)
  //             : 0.0;

  //     if (existingNumber > 0) {
  //       var removedFinalAmount = (existingNumber - double.parse(finalNumber));
  //       controller.limitOrderSellPriceTextController.text =
  //           removedFinalAmount == 0
  //               ? ''
  //               : removedFinalAmount.toStringAsFixed(percision);
  //       controller.onLimitOrderSellPriceChange(
  //           controller.limitOrderSellPriceTextController.text);
  //     }
  //   }
  //   if (formType == 'sell' && inputType == 'amount') {
  //     var existingNumber =
  //         controller.limitOrderSellAmountTextController.text != ''
  //             ? double.parse(controller.limitOrderSellAmountTextController.text)
  //             : 0.0;

  //     if (existingNumber > 0) {
  //       var removedFinalAmount = (existingNumber - double.parse(finalNumber));
  //       controller.limitOrderSellAmountTextController.text =
  //           removedFinalAmount == 0
  //               ? ''
  //               : removedFinalAmount.toStringAsFixed(percision);
  //       controller.onLimitOrderSellAmountChange(
  //           controller.limitOrderSellAmountTextController.text);
  //     }
  //   }
  // }
}
