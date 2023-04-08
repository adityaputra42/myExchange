import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/utils/extension/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
   Widget cardSearchMarket(){return Container(padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),color:const Color(0xff282831), boxShadow:const [BoxShadow(spreadRadius: 0.7,offset: Offset(0.5, 0.5),blurRadius: 1,color: Colors.white12)]),
     child: Row(children: [Image.asset(AppImage.btc, width: 36.w,),8.0.width, Expanded(
       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("BTC/IDR",style: AppFont.medium14.copyWith(color: AppColor.white),),Text("Bitcoin",style: AppFont.reguler12.copyWith(color: AppColor.darkerGray),),
         ],
       ),
     ),Column(crossAxisAlignment: CrossAxisAlignment.end,
         children: [
           Text(NumberFormat.currency(symbol: "Rp ",decimalDigits: 0, locale: "id_ID").format(12000),style: AppFont.medium14.copyWith(color: AppColor.white),),Row(
             children: [Icon(Icons.trending_up_rounded,color: AppColor.greenBuy,size: 16.w,),4.0.width,
               Text("+1.25%",style: AppFont.reguler12.copyWith(color: AppColor.greenBuy),),
             ],
           ),
         ],
       ),4.0.width],),
   );
   }

    appBar(){
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.25,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [GestureDetector(onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_rounded,size: 22.h,)),8.0.width,
              Expanded(child:
               SizedBox(height: 42.h, 
               child: TextFormField(textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(suffixIconColor: AppColor.darkerGray,
                  suffixIcon: Icon(Icons.search,size: 20.w,),fillColor: const Color(0xff3c3c43),
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    width: 1,
                    color: AppColor.errorRed,
                  ),
                ),
                  hintText: "Search Market",hintStyle: AppFont.light12.copyWith(color: AppColor.darkerGray),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r,),

                    borderSide: BorderSide(width: 1.h, color: Colors.transparent),
                    ),enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r,),
                    borderSide: BorderSide(width: 1.h, color: Colors.transparent),
                    ),focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r,),
                    borderSide: BorderSide(width: 1.h, color: AppColor.primaryColor),
                    ),
                    ),
                    ),
                    ),
                    ),
            ],
          ),
        ),
        backgroundColor:const Color(0xff282831),
      );
    }
    return Scaffold(backgroundColor:const Color(0xff1D1B23),appBar: appBar(),
    body: Padding
     (padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [24.0.height,Text("Trending Market", style: AppFont.medium16.copyWith(color: AppColor.white),),
          8.0.height, Expanded(
            child: ListView.builder( itemCount: 15, itemBuilder: (context, index)=>Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: cardSearchMarket(),
            )),
          ),
        ],
      ),
    ),);
  }
}