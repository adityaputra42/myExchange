import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/utils.dart';
import 'package:crypto_app/views/pages/trading/component/input_transaction/transaction_input.dart';
import 'package:crypto_app/views/pages/trading/component/wall/wall.dart';
import 'package:flutter/cupertino.dart';

class OrderBook extends StatelessWidget {
  const OrderBook({super.key, required this.controller, required this.tradingController});
  final HomeController controller;
  final TradingController tradingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wall(
          controller: controller,tradingController: tradingController,
        ),
        12.0.height,
        TransactionInput(),
      ],
    );
  }
}
