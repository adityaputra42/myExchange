import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/controller/search_contoller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/views/pages/home/component/list_market.dart';
import 'package:crypto_app/views/pages/home/component/news.dart';
import 'package:crypto_app/views/pages/home/component/slider_market.dart';
import 'package:crypto_app/views/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import '../../../domain/domain.dart';
import 'component/menu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
        // backgroundColor: Color(0xff1D1B23),
        gradient: const LinearGradient(colors: [
          AppColor.primaryColor,
          Color(0xff1D1B23),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        // appBar: header(),
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Image.asset(
                  AppImage.homeBg,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    // height: 54.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(children: [
                      Text(
                        'My Exchange',
                        style:
                            AppFont.semibold16.copyWith(color: AppColor.white),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=> SearchPage())!.then((value) => Get.delete<SearchController>(),);
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 20.h,
                        ),
                      ),
                      16.0.width,
                      Icon(
                        Icons.light_mode_outlined,
                        color: Colors.white,
                        size: 20.h,
                      )
                    ]),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        8.0.height,
                        News(
                          controller: controller,
                        ),
                        const Menu(),
                        16.0.height,
                        Expanded(
                          child: Container(
                            // margin: const EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.r),
                                    topRight: Radius.circular(16.r)),
                                color: const Color(0xff1D1B23)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  24.0.height,
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, bottom: 16.h),
                                    child: Text('Favorite Market',
                                        style: AppFont.medium14.copyWith(
                                            color: AppColor.white,
                                            fontStyle: FontStyle.normal)),
                                  ),
                                  SliderMarket(
                                    controller: controller,
                                  ),
                                  16.0.height,
                                  ListMarket(
                                    controller: controller,
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
