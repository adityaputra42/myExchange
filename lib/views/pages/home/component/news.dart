import 'package:carousel_slider/carousel_slider.dart';
import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class News extends StatelessWidget {
  const News({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    int index = -1;
    Widget indicator(int index) {
      return Obx(() {
        return Container(
          width: controller.currentIndex.value == index
              ? AppDimension.w40
              : AppDimension.w8,
          height: AppDimension.h8,
          margin: EdgeInsets.symmetric(horizontal: AppDimension.w2),
          decoration: BoxDecoration(
              color: controller.currentIndex.value == index
                  ? AppColor.secondaryColor
                  : AppColor.softGreen,
              borderRadius: BorderRadius.circular(AppDimension.h4)),
        );
      });
    }

    return Column(
      children: [
        CarouselSlider(
            items: controller.news
                .map(
                  (e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimension.w16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 8.h,
                          ),
                          width: double.infinity,
                          height: 170.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage(e['image']),
                                  fit: BoxFit.cover)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 48.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16.r),
                                      bottomRight: Radius.circular(16.r)),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xff282831).withOpacity(0),
                                        const Color(0xff282831).withOpacity(1)
                                      ])),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                child: Text(
                                  e['title'],
                                  style: AppFont.medium12
                                      .copyWith(color: Colors.white),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                height: 178.h,
                viewportFraction: 1,
                autoPlay: true,
                initialPage: 0,
                onPageChanged: (index, reason) {
                  controller.changeIndex(index);
                })),
        // 8.0.height,
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.news.map((e) {
              index++;
              return indicator(index);
            }).toList()),
        12.0.height,
      ],
    );
  }
}
