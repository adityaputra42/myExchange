import 'dart:async';

import 'package:crypto_app/views/pages/home/home_screen.dart';
import 'package:crypto_app/views/pages/main_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  startTime() async {
    return Timer(const Duration(milliseconds: 4500), isNewUser);
  }

  void isNewUser() async {
    Get.to (MainPage());
  }
}
