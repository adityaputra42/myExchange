class FormatedMarket {
  String? id;
  String? name;
  String? baseUnit;
  String? quoteUnit;
  double? minPrice;
  double? maxPrice;
  String? priceInUsd;
  double? minAmount;
  int? amountPrecision;
  int? pricePrecision;
  String? state;
  String? iconUrl;
  String? currencyName;
  bool? isPositiveChange;
  List<List<double>>? kline;
  String? buy;
  String? sell;
  double? low;
  double? high;
  double? open;
  double? last;
  double? volume;
  String? avgPrice;
  String? priceChangePercent;
  FormatedMarket({
    this.id,
    this.name,
    this.baseUnit,
    this.quoteUnit,
    this.minPrice,
    this.maxPrice,
    this.priceInUsd,
    this.minAmount,
    this.amountPrecision,
    this.pricePrecision,
    this.state,
    this.isPositiveChange,
    this.iconUrl,
    this.currencyName,
    this.buy,
    this.sell,
    this.kline,
    this.low,
    this.high,
    this.open,
    this.last,
    this.volume,
    this.avgPrice,
    this.priceChangePercent,
  });
}
