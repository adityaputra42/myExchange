import 'package:crypto_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/app_color.dart';
import '../../../domain/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImage.bg), fit: BoxFit.cover)),
        child: Center(
            child: Container(
          width: 160,
          height: 160,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImage.logo))),
        )),
      ),
    );
  }
}
