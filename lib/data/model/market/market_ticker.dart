import 'dart:convert';

Map<String, MarketTicker> marketTickerFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, MarketTicker>(k, MarketTicker.fromJson(v)));

String marketTickerToJson(Map<String, MarketTicker> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class MarketTicker {
  MarketTicker({
    this.at,
    this.ticker,
  });

  DateTime? at;
  Ticker? ticker;

  factory MarketTicker.fromJson(Map<String, dynamic> json) => MarketTicker(
        at: json["at"] != null
            ? DateTime.fromMillisecondsSinceEpoch(int.parse(json["at"]))
            : null,
        ticker: Ticker.fromJson(json["ticker"]),
      );

  Map<String, dynamic> toJson() => {
        "at": at,
        "ticker": ticker!.toJson(),
      };
}

class Ticker {
  Ticker({
    this.at,
    this.avgPrice,
    this.high,
    this.last,
    this.low,
    this.open,
    this.priceChangePercent,
    this.volume,
    this.amount,
  });

  String? at;
  String? avgPrice;
  String? high;
  String? last;
  String? low;
  String? open;
  String? priceChangePercent;
  String? volume;
  String? amount;

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        at: json["at"],
        avgPrice: json["avg_price"],
        high: json["high"],
        last: json["last"],
        low: json["low"],
        open: json["open"],
        priceChangePercent: json["price_change_percent"],
        volume: json["volume"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "at": at,
        "avg_price": avgPrice,
        "high": high,
        "last": last,
        "low": low,
        "open": open,
        "price_change_percent": priceChangePercent,
        "volume": volume,
        "amount": amount,
      };
}
