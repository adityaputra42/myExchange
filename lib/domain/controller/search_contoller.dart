import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var foundMarket = <FormatedMarket>[].obs;
  HomeController homeController = Get.find();
 final searchTextController = TextEditingController();
  
    @override
  void onInit() {
 foundMarket.addAll(homeController.formatedMarketsList);
    super.onInit();
  }


  searchMarket(String key,) {
    List<FormatedMarket> result = [];
    if (key.isEmpty) {
      result.addAll(homeController.formatedMarketsList);
    } else {
      result = homeController.formatedMarketsList
          .where((value) =>
              value.name!.toLowerCase().contains(key.toLowerCase()) ||
              value.currencyName!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }
    foundMarket.value = result;
  }


  @override
  void onClose() {
   foundMarket.clear();
   searchTextController.clear();
    super.onClose();
  }
}