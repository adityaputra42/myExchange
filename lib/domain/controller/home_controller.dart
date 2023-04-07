import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import '../../config/config.dart';
import '../../data/data.dart';
import '../repository/market_reposiotry.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  var tabBarIndex = 0.obs;
  var isLoading = false.obs;
  var isLoadingTicker = false.obs;
  var isLoadingMarket = false.obs;
  var isSparkLinesLoading = false.obs;
  var marketList = <Market>[].obs;
  var marketTickerList = <String, MarketTicker>{}.obs;
  var formatedMarketsList = <FormatedMarket>[].obs;
  var positiveMarketsList = <FormatedMarket>[].obs;
  var negativeMarketsList = <FormatedMarket>[].obs;
  var gainers = <FormatedMarket>[].obs;
  var losers = <FormatedMarket>[].obs;
  var volume = <FormatedMarket>[].obs;

  var orderBookSequence = -1.obs;
  var bids = <dynamic>[].obs;
  var asks = <dynamic>[].obs;
  var maxVolume = 0.0.obs;
  var selectedMarket = FormatedMarket().obs;

  var orderBookEntryBids = <dynamic>[].obs;
  var orderBookEntryAsks = <dynamic>[].obs;
  Rx<IOWebSocketChannel>? channel;
  List<Map<String, dynamic>> news = [
    {"image": AppImage.news1, "title": "Potensi pasar cryptocurrency di dunia"},
    {"image": AppImage.news2, "title": "Harga Bitcoin naik"},
    {"image": AppImage.news3, "title": "Harga Binance Mengalami penurunan"},
    {"image": AppImage.news4, "title": "Listing baru coin Etherium"},
  ];
  // WebSocketController? webSocketController;

  @override
  void onInit() async {
    await fetchMarket();

    Websocket.instance.streamController.stream.listen((message) {
      var data = json.decode(message);
      if (data.containsKey('global.tickers')) {
        updateMarketData(data['global.tickers']);
      }
    }, onDone: () {
      debugPrint("Task Done1");
    }, onError: (error) {
      debugPrint("Some Error1");
    });
    super.onInit();
  }

  Future<void> fetchMarket() async {
    MarketRepository marketRepository = MarketRepository();

    try {
      isLoading.value = true;
      var markets = await marketRepository.fetchMarket();
      var marketsTickers = await marketRepository.fetchTicker();
     
      marketTickerList.assignAll(marketsTickers);
      formateMarkets(
        markets,
        marketsTickers,
      );

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
    }
  }

  void setMarket(FormatedMarket market) {
    selectedMarket.value = market;
  }

  void formateMarkets(
    List<Market> markets,
    Map<String, dynamic> tickers,
  ) async {
    var marketsFormatedData = <FormatedMarket>[];
    var positivemarketsFormatedData = <FormatedMarket>[];
    var negativemarketsFormatedData = <FormatedMarket>[];
    for (Market market in markets) {
      if (tickers[market.id] != null) {
        var priceInUsd = '';
        bool isPositiveChange = true;
        double marketLast = double.parse(tickers[market.id].ticker.last);
        double marketOpen = tickers[market.id].ticker.open.runtimeType != double
            ? double.parse(tickers[market.id].ticker.open)
            : tickers[market.id].ticker.open;
        String marketPriceChangePercent =
            tickers[market.id].ticker.priceChangePercent;
        double marketHigh = double.parse(tickers[market.id].ticker.high);
        double marketLow = double.parse(tickers[market.id].ticker.low);
        double marketVolume = double.parse(tickers[market.id].ticker.volume);
        double change = (marketLast - marketOpen);
        if (change < 0) {
          isPositiveChange = false;
        }
        priceInUsd = market.quoteUnit == 'usd'
            ? priceInUsd = marketLast.toStringAsFixed(2)
            : getBaseUnitPriceInUsd(market.baseUnit ?? "", tickers, false);

        MarketTicker marketTicker = tickers[market.id];
        debugPrint(marketTicker.ticker?.last);

        var formatedMarket = FormatedMarket(
          id: market.id,
          name: market.name,
          baseUnit: market.baseUnit,
          quoteUnit: market.quoteUnit,
          minPrice: market.minPrice,
          maxPrice: market.maxPrice,
          priceInUsd: priceInUsd,
          currencyName: market.fullname,
          iconUrl: market.logoUrl,
          amountPrecision: market.amountPrecision,
          kline: market.kline,
          pricePrecision: market.pricePrecision,
          state: market.state,
          isPositiveChange: isPositiveChange,
          low: marketLow,
          high: marketHigh,
          open: marketOpen,
          last: marketLast,
          volume: marketVolume,
          avgPrice: tickers[market.id].ticker.avgPrice,
          priceChangePercent: marketPriceChangePercent,
        );
        if (isPositiveChange) {
          positivemarketsFormatedData.add(formatedMarket);
        } else {
          negativemarketsFormatedData.add(formatedMarket);
        }
        marketsFormatedData.add(formatedMarket);
      }
    }
    formatedMarketsList.assignAll(marketsFormatedData);
    gainers.assignAll(marketsFormatedData);

    losers.assignAll(marketsFormatedData);

    volume.assignAll(marketsFormatedData);

    positiveMarketsList.assignAll(positivemarketsFormatedData);
    negativeMarketsList.assignAll(negativemarketsFormatedData);

    gainers.sort(
      (a, b) => double.parse(
              a.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))
          .compareTo(double.parse(
              b.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))),
    );

    losers.sort(
      (a, b) => double.parse(
              a.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))
          .compareTo(double.parse(
              b.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))),
    );

    volume.sort(((a, b) => a.volume!.compareTo(b.volume!)));
  }

  String getBaseUnitPriceInUsd(
      String baseUnit, Map<String, dynamic> tickers, bool fromWebSocket) {
    var priceInUsd = '---';

    var market = marketList.firstWhere(
        (market) =>
            market.baseUnit!.toLowerCase() == baseUnit.toLowerCase() &&
            market.quoteUnit == 'usd',
        orElse: () => Market());

    if (market.id != null) {
      double lastPrice = fromWebSocket
          ? double.parse(tickers[market.id]['last'])
          : double.parse(tickers[market.id].ticker.last);
      priceInUsd = lastPrice.toStringAsFixed(2);
    }
    return priceInUsd;
  }

  void updateMarketData(tickers) {
    for (FormatedMarket market in formatedMarketsList) {
      if (tickers[market.id] != null) {
        var priceInUsd = '---';
        bool isPositiveChange = true;
        double marketLast = double.parse(tickers[market.id]['last']);
        double marketOpen = tickers[market.id]['open'].runtimeType != double
            ? double.parse(tickers[market.id]['open'])
            : tickers[market.id]['open'];
        String marketPriceChangePercent =
            tickers[market.id]['price_change_percent'];
        double marketHigh = double.parse(tickers[market.id]['high']);
        double marketLow = double.parse(tickers[market.id]['low']);
        double marketVolume = double.parse(tickers[market.id]['volume']);
        double change = (marketLast - marketOpen);
        if (change < 0) {
          isPositiveChange = false;
        }
        priceInUsd = market.quoteUnit == 'usd'
            ? priceInUsd = marketLast.toStringAsFixed(2)
            : getBaseUnitPriceInUsd(market.baseUnit ?? "", tickers, true);
        market.avgPrice = tickers[market.id]['avg_price'];
        market.high = marketHigh;
        market.last = marketLast;
        market.priceInUsd = priceInUsd;
        market.low = marketLow;
        market.open = marketOpen;

        market.priceChangePercent = marketPriceChangePercent;
        market.volume = marketVolume;
        isPositiveChange = isPositiveChange;
        if (selectedMarket.value.id == market.id) {
          selectedMarket.value = market;
          selectedMarket.refresh();
        }

        int positiveExistingIndex = positiveMarketsList
            .indexWhere((element) => element.id == market.id);
        int negativeExistingIndex = negativeMarketsList
            .indexWhere((element) => element.id == market.id);
        if (isPositiveChange) {
          if (positiveExistingIndex != -1) {
            positiveMarketsList[positiveExistingIndex] = market;
          } else {
            positiveMarketsList.add(market);
            if (negativeExistingIndex != -1) {
              negativeMarketsList.removeAt(negativeExistingIndex);
            }
          }
        } else {
          if (negativeExistingIndex != -1) {
            negativeMarketsList[negativeExistingIndex] = market;
          } else {
            negativeMarketsList.add(market);
            if (positiveExistingIndex != -1) {
              positiveMarketsList.removeAt(positiveExistingIndex);
            }
          }
        }

        //Update Tickers List
        marketTickerList[market.id]?.ticker!.high = marketHigh.toString();
        marketTickerList[market.id]?.ticker!.low = marketLow.toString();
        marketTickerList[market.id]?.ticker!.open = marketOpen.toString();
        marketTickerList[market.id]?.ticker!.last = marketLast.toString();
        marketTickerList[market.id]?.ticker!.volume = marketVolume.toString();
        marketTickerList[market.id]?.ticker!.avgPrice =
            tickers[market.id]['avg_price'];
        marketTickerList[market.id]?.ticker!.priceChangePercent =
            marketPriceChangePercent;
      }
      formatedMarketsList.refresh();
      positiveMarketsList.refresh();
      negativeMarketsList.refresh();
      gainers.refresh();
      losers.refresh();
      volume.refresh();
      gainers.sort(
        (a, b) => double.parse(
                a.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))
            .compareTo(double.parse(
                b.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))),
      );

      losers.sort(
        (a, b) => double.parse(
                a.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))
            .compareTo(double.parse(
                b.priceChangePercent!.replaceAll('+', '').replaceAll('%', ''))),
      );

      volume.sort(((a, b) => a.volume!.compareTo(b.volume!)));
      // print('---WS MAREKTS MESSAGE---');
    }
  }

  @override
  void onClose() {}

  void changeIndex(int index) => currentIndex.value = index;
  void setTabBarIndex(int index) => tabBarIndex.value = index;
}
