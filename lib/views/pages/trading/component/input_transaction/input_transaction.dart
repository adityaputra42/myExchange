import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../config/config.dart';

class InputTransaction extends StatelessWidget {
  final Function() kurangData;
  final Function() tambahData;
  final String hint;
  final Function(String)? onChanged;
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
      this.onChanged,
      this.validate,
      this.onEditingConmplete,
      this.focusNode,
      this.textInputAction,
      this.ontap,
      this.precision,
      required this.kurangData,
      required this.tambahData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: kurangData,
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
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
              ],
              controller: controller,
              style: AppFont.reguler12.copyWith(
                color: Theme.of(context).indicatorColor,
                fontSize: 13.sp,
                fontFamily: "Roboto",
              ),
              textAlign: TextAlign.center,
              showCursor: false,
              cursorColor: Theme.of(context).indicatorColor,
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
          onTap: tambahData,
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
}
