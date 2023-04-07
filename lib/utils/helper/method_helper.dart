import 'dart:math';
import 'package:flutter/material.dart';

import '../../config/config.dart';

class MethodHelper {
  Widget generateDashedDivider(double width) {
    int n = width ~/ 5;
    return Row(
      children: List.generate(
          n,
          (index) => (index % 2 == 0)
              ? Container(
                  height: 2,
                  width: width / n,
                  color: AppColor.softGreen,
                )
              : SizedBox(
                  width: width / n,
                )),
    );
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).floor().toDouble() / mod);
  }

  static List<dynamic> accumulateVolume(List<dynamic> list) {
    List<dynamic> total = [];
    List<dynamic> volArr = [];
    for (var i = 0; i < list.length; i++) {
      volArr.add(double.parse(list[i][1] != '' ? list[i][1] : '0'));
    }
    for (var i = 0; i < volArr.length; i++) {
      var accumulator = i - 1 > -1 ? total[i - 1] : 0;
      total.add(accumulator + volArr[i]);
    }
    return total;
  }

  static dynamic calcMaxVolume(bids, asks) {
    List<dynamic> combinedList = [
      ...accumulateVolume(bids),
      ...accumulateVolume(asks)
    ];
    final maxValue =
        combinedList.isNotEmpty ? combinedList.cast<num>().reduce(max) : 0.0;
    return maxValue;
  }

  static dynamic mapValues(maxVolume, data) {
    var resultData = data != null && maxVolume != 0 && data.length > 0
        ? data.map((currentVolume) {
            return {"value": (currentVolume / maxVolume) * 100};
          }).toList()
        : [];

    return resultData;
  }
}
