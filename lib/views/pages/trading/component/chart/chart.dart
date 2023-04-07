import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/views/pages/trading/component/chart/candle_chart.dart';
import 'package:crypto_app/views/pages/trading/component/chart/depth_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.controller});
  final TradingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CandleChart(
          controller: controller,
        ),
        12.0.height,
        DepthChartPage(
          controller: controller,
        )
      ],
    );
  }
}
