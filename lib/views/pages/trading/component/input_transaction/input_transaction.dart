import 'package:crypto_app/utils/helper/method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../../../../../../../config/config.dart';

class InputTransaction extends StatelessWidget {

  final String hint;
  final Function(String) onChanged;
  final String? Function(String?)? validate;
  final Function()? onEditingConmplete;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? precision;

  final Function()? ontap;
  final TextEditingController controller;

  const InputTransaction(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.onChanged,
      this.validate,
      this.onEditingConmplete,
      this.focusNode,
      this.textInputAction,
      this.ontap,
      this.precision,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap:()=> removeValueFromInput(context, precision??0),
          focusColor: AppColor.primaryColor,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(width: 2.h, color: AppColor.primaryColor)),
          child: Container(
            width: AppDimension.w48,
            height: AppDimension.h40,
            margin: EdgeInsets.only(right: AppDimension.w6),
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                // border: Border.all(width: 1, color: AppColor.softGreen),
                borderRadius: BorderRadius.circular(8.r)),
            child: const Icon(
              Icons.remove,
              color: AppColor.softGreen,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: AppDimension.h40,
            child: TextFormField(
              onTap: ontap,
              validator: validate,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: onChanged,
              onEditingComplete: onEditingConmplete,
              focusNode: focusNode,
              textInputAction: textInputAction,
              inputFormatters: [
             ThousandsFormatter(
                          allowFraction: true,
                          formatter: NumberFormat('#,##0.${"#" * precision!}'))
              ],
              controller: controller,
              style: AppFont.reguler12.copyWith(
                color: AppColor.white,
                fontSize: 13.sp,
                fontFamily: "Roboto",
                
              ),
              textAlign: TextAlign.center,
              showCursor: false,
              cursorColor: AppColor.white,
              textAlignVertical: TextAlignVertical.bottom,
              decoration: InputDecoration(
                fillColor: const Color(0xff3c3c43),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColor.errorRed,
                  ),
                ),
                hintText: hint,
                hintStyle: AppFont.light12.copyWith(
                  color: AppColor.darkerGray,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: ()=> addValueToInput(context, precision??0),
          focusColor: AppColor.primaryColor,
          customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(width: 2.h, color: AppColor.primaryColor)),
          child: Container(
            width: AppDimension.w48,
            height: AppDimension.h40,
            margin: EdgeInsets.only(left: 6.w),
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                // border: Border.all(width: 1, color: AppColor.softGreen),
                borderRadius: BorderRadius.circular(8.r)),
            child: const Icon(
              Icons.add,
              color: AppColor.softGreen,
            ),
          ),
        )
      ],
    );
  }

  
  void addValueToInput(
      BuildContext context, int percision) {
    FocusScope.of(context).unfocus();
    var number = 1;
    var decimalPointNumber = number.toString().padRight(percision + 1, '0');
    var maxNumber = int.parse(decimalPointNumber);
    var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
      var existingNumber =
          controller.text != ''
              ? double.parse(MethodHelper.convertToNumber(controller.text))
              : 0.0;

      controller.text =
          (existingNumber + double.parse(finalNumber))
              .toStringAsFixed(percision);
      onChanged(
          controller.text);
   
  }

  void removeValueFromInput(
      BuildContext context, int percision) {
    FocusScope.of(context).unfocus();
    var number = 1;
    var decimalPointNumber = number.toString().padRight(percision + 1, '0');
    var maxNumber = int.parse(decimalPointNumber);
    var finalNumber = (1 / maxNumber).toStringAsFixed(percision);
  
      var existingNumber =
          controller.text != ''
              ? double.parse(MethodHelper.convertToNumber(controller.text))
              : 0.0;

      if (existingNumber > 0) {
        var removedFinalAmount = (existingNumber - double.parse(finalNumber));

        controller.text =
            removedFinalAmount == 0
                ? ''
                : removedFinalAmount.toStringAsFixed(percision);
       onChanged(
            controller.text);
      }
   
  }
}
