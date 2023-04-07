import 'dart:convert';

List<Market> marketFromJson(String str) =>
    List<Market>.from(json.decode(str).map((x) => Market.fromJson(x)));

String marketToJson(List<Market> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Market {
  Market({
    this.id,
    this.symbol,
    this.name,
    this.fullname,
    this.logoUrl,
    this.type,
    this.baseUnit,
    this.quoteUnit,
    this.minPrice,
    this.maxPrice,
    this.minAmount,
    this.amountPrecision,
    this.pricePrecision,
    this.totalPrecision,
    this.state,
    this.kline,
  });

  String? id;
  String? symbol;
  String? name;
  String? fullname;
  String? logoUrl;
  String? type;
  String? baseUnit;
  String? quoteUnit;
  double? minPrice;
  double? maxPrice;
  double? minAmount;
  int? amountPrecision;
  int? pricePrecision;
  int? totalPrecision;
  String? state;
  List<List<double>>? kline;

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["id"] == null ? null : json["id"] as String,
        symbol: json["symbol"] == null ? null : json["symbol"] as String,
        name: json["name"] == null ? null : json["name"] as String,
        fullname: json["fullname"] == null ? null : json["fullname"] as String,
        logoUrl: json["logo_url"] == null ? null : json["logo_url"] as String,
        type: json["type"] == null ? null : json["type"] as String,
        baseUnit:
            json["base_unit"] == null ? null : json["base_unit"] as String,
        quoteUnit:
            json["quote_unit"] == null ? null : json["quote_unit"] as String,
        minPrice: json["min_price"] == null
            ? null
            : double.parse(json["min_price"].toString()),
        maxPrice: json["max_price"] == null
            ? null
            : double.parse(json["max_price"].toString()),
        minAmount: json["min_amount"] == null
            ? null
            : double.parse(json["min_amount"].toString()),
        amountPrecision: json["amount_precision"] == null
            ? null
            : json["amount_precision"] as int,
        pricePrecision: json["price_precision"] == null
            ? null
            : json["price_precision"] as int,
        totalPrecision: json["total_precision"] == null
            ? null
            : json["total_precision"] as int,
        state: json["state"] == null ? null : json["state"] as String,
        kline: json["kline"] == null
            ? []
            : List<List<double>>.from(json["kline"]!
                .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "fullname": fullname,
        "logo_url": logoUrl,
        "type": type,
        "base_unit": baseUnit,
        "quote_unit": quoteUnit,
        "min_price": minPrice,
        "max_price": maxPrice,
        "min_amount": minAmount,
        "amount_precision": amountPrecision,
        "price_precision": pricePrecision,
        "total_precision": totalPrecision,
        "state": state,
        // "kline": kline == null
        //     ? []
        //     : List<dynamic>.from(
        //         kline!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
