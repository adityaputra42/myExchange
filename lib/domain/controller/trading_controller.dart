import 'dart:convert';

import 'package:candlestick_digiasset/candlestick_digiasset.dart';
import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import 'package:crypto_app/domain/controller/controller.dart';
import 'package:crypto_app/utils/helper/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../utils/helper/ws_helper.dart';
import '../repository/market_reposiotry.dart';

List<Candle> generateCandle(List<List<double>> data) {
  var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
  List<Candle> candles = [];
  for (var i = 0; i < data.length; i++) {
    Map<String, dynamic> newObj = {};
    for (var j = 0; j < keys.length; j++) {
      newObj.addAll({keys[j]: data[i][j]});
    }
    int? tempTime = newObj['time']?.toInt() * 1000;

    if (tempTime == null) {
      tempTime = newObj['id']?.toInt() ?? 0;
      tempTime = tempTime! * 1000;
    }

    candles.add(Candle(
        date: DateTime.fromMillisecondsSinceEpoch(tempTime),
        high: double.parse(newObj['high'].toString()),
        low: double.parse(newObj['low'].toString()),
        open: double.parse(newObj['open'].toString()),
        close: double.parse(newObj['close'].toString()),
        volume: double.parse(newObj['vol'].toString())));

  
  }

  return candles;
}

class TradingController extends GetxController {
  var initialLineGraphTimeSlots = [
    {"key": "1m", "name": "1 minutes", "valueInMinute": "1", "isActive": false},
    {"key": "5m", "name": "5 minutes", "valueInMinute": "5", "isActive": false},
    {
      "key": "15m",
      "name": "15 minutes",
      "valueInMinute": "15",
      "isActive": false
    },
    {
      "key": "30m",
      "name": "30 minutes",
      "valueInMinute": "30",
      "isActive": false
    },
    {"key": "1h", "name": "1 hour", "valueInMinute": "60", "isActive": false},
    {"key": "4h", "name": "4 hour", "valueInMinute": "240", "isActive": false},
    {
      "key": "12h",
      "name": "12 hour",
      "valueInMinute": "720",
      "isActive": false
    },
    {"key": "1D", "name": "1 day", "valueInMinute": "1440", "isActive": false},
    {
      "key": "1w",
      "name": "1 week",
      "valueInMinute": "10080",
      "isActive": false
    },
  ].obs;
  var lineGraphTimeSlots = [
    {"key": "1m", "name": "1 minute", "valueInMinute": "1", "isActive": false},
    {"key": "5m", "name": "5 minutes", "valueInMinute": "5", "isActive": false},
    {
      "key": "30m",
      "name": "30 minutes",
      "valueInMinute": "30",
      "isActive": false
    },
    {"key": "2h", "name": "2 hours", "valueInMinute": "120", "isActive": false},
    {"key": "6h", "name": "6 hours", "valueInMinute": "360", "isActive": false},
    {"key": "3D", "name": "3 days", "valueInMinute": "4320", "isActive": false},
    {
      "key": "1M",
      "name": "1 month",
      "valueInMinute": "43800",
      "isActive": false
    },
  ].obs;
  var dropdownShown = false.obs;
 
  var market = FormatedMarket().obs;
  HomeController homeController = Get.find();
  var selectedIndex = 0.obs;
  var formatedKLineData = <KLineEntity>[].obs;
  var selectedOrder = 0.obs;
  var selectedBuySell = 0.obs;
  var widthLine = 0.obs;
  var intervalLine = 0.obs;
  var maxY = 0.obs;
  var candles = <Candle>[].obs;
  var isCandleAdd = false.obs;
  var isLoadingLandscape = false.obs;
  var selectedOption = <String, dynamic>{}.obs;
  var isKLineLoading = true.obs;
  var isChinese = false;
  var isHistoryTradeLoading = false.obs;
  var bidsData = <DepthEntity>[].obs;
  var asksData = <DepthEntity>[].obs;
 var historyTrade = <TradesModel>[].obs;
  var fecthingTradeLoading = false.obs;
  var duration = 1.obs;
  var priceController = TextEditingController();
  var amountController = TextEditingController();
  var sliderBuy =0.0.obs;
  var sliderSell = 0.0.obs;
  var balanceBase = 12.564.obs;
  var balanceQuote = 120.0.obs;
  var totalPrice = 0.0.obs;






  @override
  void onInit() async {
    market = homeController.selectedMarket;
    await setDefaultValues();
    getKlineData();
    super.onInit();
  }

  @override
  void onReady() async {
    homeController.orderBookSequence = -1;
    homeController.asks.clear();
    homeController.bids.clear();

    await Websocket.instance.subscribeKline(
        market.value, initialLineGraphTimeSlots[2]['key'].toString());
    getKlineDataFromWS();

    await Websocket.instance.subscribeOrderBookInc(market.value);
   
    getOrderBookDataFromWS();
    super.onReady();
  }

  void changeIndex(int index) => selectedIndex.value = index;
  void changeOrder(int index) => selectedOrder.value = index;
  void changeBuySell(int index) => selectedBuySell.value = index;

  void setDuration(String timeKey) {
    if (timeKey == '1m') {
      duration.value = 1;
      widthLine.value = 20;
      intervalLine.value = 1000000;
    } else if (timeKey == '5m') {
      duration.value = 3;
      widthLine.value = 10;
      intervalLine.value = 10000000;
    } else if (timeKey == '15m') {
      duration.value = 5;
      widthLine.value = 9;
      intervalLine.value = 100000000;
    } else if (timeKey == '30m') {
      duration.value = 10;
      widthLine.value = 8;
      intervalLine.value = 100000000;
    } else if (timeKey == '1h') {
      duration.value = 20;
      widthLine.value = 6;
      intervalLine.value = 100000000;
    } else if (timeKey == '4h') {
      duration.value = 80;
      widthLine.value = 5;
      intervalLine.value = 100000000;
    } else if (timeKey == '12h') {
      duration.value = 180;
      widthLine.value = 4;
      intervalLine.value = 100000000;
    } else if (timeKey == '1D') {
      duration.value = 365;
      widthLine.value = 3;
      intervalLine.value = 200000000;
    } else {
      duration.value = 730;
      widthLine.value = 2;
      intervalLine.value = 500000000;
    }
  }

  void updateCurrentMarket(FormatedMarket newMarket) async {
    Websocket.instance
        .unSubscribeKline(market.value, selectedOption['valueInMinute']);
    Websocket.instance.unSubscribeOrderBookInc(market.value);
    market.value = newMarket;
    homeController.selectedMarket.value = newMarket;

    await getKlineData();
    Websocket.instance
        .subscribeKline(newMarket, selectedOption['valueInMinute']);
    Websocket.instance.subscribeOrderBookInc(newMarket);
  }

  void updateKlineTimeOption(newOption) async {
    Websocket.instance.unSubscribeKline(market.value, selectedOption['key']);
    selectedOption.assignAll(newOption);
    await getKlineData();

    Websocket.instance.subscribeKline(market.value, selectedOption['key']);
  }

  Future<void> setDefaultValues() async {
    selectedOption.assignAll(initialLineGraphTimeSlots[2]);
  }

  Future<void> refreshPage() async {
    onClose();
    onInit();
    onReady();
  }

  Future<void> getKlineData() async {
    MarketRepository marketRepository = MarketRepository();
    try {
      isKLineLoading(true);
      var period = selectedOption['valueInMinute'];
      setDuration(selectedOption['key']);
      var currentTime = DateTime.now();

      var from = (currentTime
                  .subtract(Duration(days: duration.value))
                  .millisecondsSinceEpoch /
              1000)
          .floor();
      var to = (currentTime.millisecondsSinceEpoch / 1000).floor();

      var data = await marketRepository.fetchKLineData(
          market: market.value.id!, period: period, from: (from), to: to);
      final result = await compute(generateCandle, data);
      candles.addAll(result);
      candles.refresh();

      isKLineLoading(false);
      
      isKLineLoading(false);
    } catch (error) {
      isKLineLoading(false);


    }
  }

  void makeDepthData() {
    asksData.clear();
    bidsData.clear();
    var bids = homeController.bids
        .map(
            (item) => DepthEntity(double.parse(item[0]), double.parse(item[1])))
        .toList()
        .cast<DepthEntity>();
    var asks = homeController.asks
        .map(
            (item) => DepthEntity(double.parse(item[0]), double.parse(item[1])))
        .toList()
        .cast<DepthEntity>();
    
    initDepth(bids, asks);
    bidsData.refresh();
    asksData.refresh();
  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids.isEmpty || asks.isEmpty) return;

    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));
    for (var item in bids.reversed) {
      amount += item.vol;
      item.vol = amount;
      bidsData.insert(0, item);
    }

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));
    for (var item in asks) {
      amount += item.vol;
      item.vol = amount;
      asksData.add(item);
    }
  }

  void getKlineDataFromWS() {
    Websocket.instance.streamController.stream.listen((message) {
      var data = json.decode(message);
      if (data
          .containsKey('${market.value.id}.kline-${selectedOption['key']}')) {
        var keys = ['time', 'open', 'high', 'low', 'close', 'vol'];
        Map<String, dynamic> newObj = {};
       
        for (var i = 0; i < keys.length; i++) {
          var kLineEntry =
              data['${market.value.id}.kline-${selectedOption['key']}'][i];
          newObj.addAll({keys[i]: kLineEntry});
        }
        int? tempTime = newObj['time']?.toInt() * 1000;

        if (tempTime == null) {
          tempTime = newObj['id']?.toInt() ?? 0;
          tempTime = tempTime! * 1000;
        }

        DateTime date = DateTime.fromMillisecondsSinceEpoch(tempTime);
        var candleDate = DateFormat("dd MM yyyy H:mm").format(date);
        var dateNow = DateFormat("dd MM yyyy H:mm").format(DateTime.now());
       
        if (candleDate == dateNow) {
          if (isCandleAdd.isFalse) {
            candles.add(Candle(
                date: DateTime.fromMillisecondsSinceEpoch(tempTime).toLocal(),
                high: double.parse(newObj['high'].toString()),
                low: double.parse(newObj['low'].toString()),
                open: double.parse(newObj['open'].toString()),
                close: double.parse(newObj['close'].toString()),
                volume: double.parse(newObj['vol'].toString())));
            isCandleAdd.value = true;
          } else {
            candles.removeLast();
            candles.add(Candle(
                date: DateTime.fromMillisecondsSinceEpoch(tempTime).toLocal(),
                high: double.parse(newObj['high'].toString()),
                low: double.parse(newObj['low'].toString()),
                open: double.parse(newObj['open'].toString()),
                close: double.parse(newObj['close'].toString()),
                volume: double.parse(newObj['vol'].toString())));
          }
        } else {
          isCandleAdd.value = false;
        }

        candles.refresh();

        // DataUtil.calculate(formatedKLineData);
      }
    }, onDone: () {
      print("K Line data done");
    }, onError: (error) {
      print("K Line data Error");
    });
  }

  void getOrderBookDataFromWS() {
    Websocket.instance.streamController.stream.listen((message) {
      var data = json.decode(message);

      if (data.containsKey('${market.value.id}.ob-snap')) {
        homeController.asks
            .assignAll(data['${market.value.id}.ob-snap']['asks']);
        homeController.bids
            .assignAll(data['${market.value.id}.ob-snap']['bids']);
        homeController.orderBookSequence =
            data['${market.value.id}.ob-snap']['sequence'];

        homeController.maxVolume.value = MethodHelper.calcMaxVolume(
            homeController.bids, homeController.asks);
        homeController.orderBookEntryBids
            .assignAll(MethodHelper.accumulateVolume(homeController.bids));
        homeController.orderBookEntryAsks
            .assignAll(MethodHelper.accumulateVolume(homeController.asks));

        makeDepthData();
      }
      if (data.containsKey('${market.value.id}.ob-inc')) {
        var updatedAsksData = [];
        var updatedBidsData = [];
        if (homeController.orderBookSequence == -1) {
          return;
        }
        if (homeController.orderBookSequence + 1 !=
            data['${market.value.id}.ob-inc']['sequence']) {
          return;
        }
        if (data['${market.value.id}.ob-inc']['asks'] != null) {
          var asks = data['${market.value.id}.ob-inc']['asks'];
          if (WsHelper.isArray(asks[0].toString())) {
            for (var i = 0; i < asks.length; i++) {
              updatedAsksData = WsHelper.handleIncrementalUpdate(
                  homeController.asks, asks[i], 'asks');
            }
          } else {
            updatedAsksData = WsHelper.handleIncrementalUpdate(
                homeController.asks, asks, 'asks');
          }

          updatedAsksData = updatedAsksData.length >= 10
              ? updatedAsksData.sublist(0, 10)
              : updatedAsksData;
          homeController.asks.assignAll(updatedAsksData);
          homeController.asks.refresh();
          homeController.maxVolume.value =
              MethodHelper.calcMaxVolume(homeController.bids, updatedAsksData);
          homeController.orderBookEntryBids
              .assignAll(MethodHelper.accumulateVolume(homeController.bids));
          homeController.orderBookEntryAsks
              .assignAll(MethodHelper.accumulateVolume(updatedAsksData));
          makeDepthData();
        }
        if (data['${market.value.id}.ob-inc']['bids'] != null) {
          var bids = data['${market.value.id}.ob-inc']['bids'];
          if (WsHelper.isArray(bids[0].toString())) {
            for (var i = 0; i < bids.length; i++) {
              updatedBidsData = WsHelper.handleIncrementalUpdate(
                  homeController.bids, bids[i], 'bids');
            }
          } else {
            updatedBidsData = WsHelper.handleIncrementalUpdate(
                homeController.bids, bids, 'bids');
          }
          updatedBidsData = updatedBidsData.length >= 10
              ? updatedBidsData.sublist(0, 10)
              : updatedBidsData;

          homeController.bids.assignAll(updatedBidsData);
          homeController.bids.refresh();
          homeController.maxVolume.value =
              MethodHelper.calcMaxVolume(updatedBidsData, homeController.asks);
          homeController.orderBookEntryBids
              .assignAll(MethodHelper.accumulateVolume(updatedBidsData));
          homeController.orderBookEntryAsks
              .assignAll(MethodHelper.accumulateVolume(homeController.asks));
          makeDepthData();
        }

        homeController.orderBookSequence =
            data['${market.value.id}.ob-inc']['sequence'];
      }
    }, onDone: () {
      print("Task Done1");
    }, onError: (error) {
      print("Some Error1");
    });
  }

  void onPriceChange(String value) {
    calculateTotalPrice();
    
    
  }
  void onAmountChange(String value) {
    calculateTotalPrice();
    
  }

  void setSliderPercent(
      {required double value }) {
   
      if (selectedBuySell.value == 0) {
        sliderBuy.value = value;
        if (priceController.text != '') {
          double jumlahAmount = ((sliderBuy.value *
             roundDouble(
                          balanceQuote.value , market.value.pricePrecision??0)) /
                  100) /
              double.parse(MethodHelper.convertToNumber(
                  priceController.text));
         
          amountController.text = jumlahAmount == 0
              ? ""
              : NumberFormat.currency(
                      locale: 'en_US',
                      decimalDigits: market.value.amountPrecision??0,
                      symbol: '')
                  .format(double.parse(
                      jumlahAmount.toStringAsFixed(market.value.amountPrecision??0)));

          calculateTotalPrice();
        }
      } else {
        sliderSell.value = value;
      
        double jumlahAmount = ((sliderSell.value *
                roundDouble(balanceBase.value, market.value.amountPrecision??0)) /
            100);

      amountController.text = jumlahAmount == 0
            ? ""
            : NumberFormat.currency(
                    locale: 'en_US',
                    decimalDigits: market.value.amountPrecision,
                    symbol: '')
                .format(
                    double.parse(jumlahAmount.toStringAsFixed(market.value.amountPrecision??0)));
        calculateTotalPrice();
        
      }
    } 
  
 void setBidFormPrice(List<dynamic> bid) {
    priceController.text = bid[0];
    onPriceChange(priceController.text);
  
  }

    void setAskFormPrice(List<dynamic> ask) {
     priceController.text = ask[0];
    onPriceChange(priceController.text);
  }
  // void calculateLimitOrderBuyAmount() {
  //   if (limitOrderBuyPriceTextController.text != '' &&
  //       limitOrderBuyTotalTextController.text != '') {
  //     double buyPrice = double.parse(CurrencyHelper.convertToNumber(
  //         limitOrderBuyPriceTextController.text));
  //     double buyTotal = double.parse(CurrencyHelper.convertToNumber(
  //         limitOrderBuyTotalTextController.text));
  //     double buyAmount = buyTotal / buyPrice;

  //     limitOrderBuyAmountTextController.text = NumberFormat.currency(
  //             locale: 'id_ID',
  //             decimalDigits: market.value.amountPrecision,
  //             symbol: '')
  //         .format(buyAmount);
  //   } else {
  //     limitOrderBuyAmountTextController.text = '';
  //   }
  // }

  void calculateTotalPrice() {
    if (priceController.text != '' &&
        amountController.text != '') {
      double sellPrice = double.parse(MethodHelper .convertToNumber(
          priceController.text));
      double sellAmount = double.parse(MethodHelper.convertToNumber(
          amountController.text));
      double sellTotal = sellPrice * sellAmount;
      totalPrice.value = sellTotal;
    
    } else {
      
      totalPrice.value = 0;
    }
  }

  // void calculateLimitOrderSellAmount() {
  //   if (limitOrderSellPriceTextController.text != '' &&
  //       limitOrderSellTotalTextController.text != '') {
  //     double sellPrice = double.parse(CurrencyHelper.convertToNumber(
  //         limitOrderSellPriceTextController.text));
  //     double sellTotal = double.parse(CurrencyHelper.convertToNumber(
  //         limitOrderSellTotalTextController.text));
  //     double sellAmount = sellTotal / sellPrice;
  //     limitOrderSellAmountTextController.text = NumberFormat.currency(
  //             locale: 'id_ID',
  //             decimalDigits: market.value.amountPrecision,
  //             symbol: '')
  //         .format(sellAmount);
  //   } else {
  //     limitOrderSellAmountTextController.text = '';
  //   }
  // }
  @override
  void onClose() {
    market.value = FormatedMarket();
    Websocket.instance.unSubscribeKline(market.value, selectedOption['key']);
    homeController.asks.clear();
    homeController.bids.clear();
    homeController.orderBookEntryAsks.clear();
    homeController.orderBookEntryBids.clear();
    homeController.orderBookSequence = 0;
    Websocket.instance.unSubscribeOrderBookInc(market.value);
  }
}
