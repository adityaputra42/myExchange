class OrderModel {
  OrderModel({
    this.id,
    this.uuid,
    this.side,
    this.orderType,
    this.price,
    this.avgPrice,
    this.state,
    this.market,
    this.marketType,
    this.createdAt,
    this.updatedAt,
    this.originVolume,
    this.remainingVolume,
    this.executedVolume,
    this.makerFee,
    this.takerFee,
    this.tradesCount,
  });

  int? id;
  String? uuid;
  String? side;
  String? orderType;
  double? price;
  double? avgPrice;
  String? state;
  String? market;
  String? marketType;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? originVolume;
  double? remainingVolume;
  double? executedVolume;
  double? makerFee;
  double? takerFee;
  int? tradesCount;
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] == null ? null : json["id"] as int,
        uuid: json["uuid"] == null ? null : json["uuid"] as String,
        side: json["side"] == null ? null : json["side"] as String,
        orderType: json["ord_type"] == null ? null : json["ord_type"] as String,
        price: json["price"] == null ? null : double.tryParse(json["price"]),
        avgPrice: json["avg_price"] == null
            ? null
            : double.tryParse(json["avg_price"]),
        state: json["state"] == null ? null : json["state"] as String,
        market: json["market"] == null ? null : json["market"] as String,
        marketType:
            json["market_type"] == null ? null : json["market_type"] as String,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        originVolume: json["origin_volume"] == null
            ? null
            : double.tryParse(json["origin_volume"]),
        remainingVolume: json["remaining_volume"] == null
            ? null
            : double.tryParse(json["remaining_volume"]),
        executedVolume: json["executed_volume"] == null
            ? null
            : double.tryParse(json["executed_volume"]),
        makerFee: json["maker_fee"] == null
            ? null
            : double.tryParse(json["maker_fee"]),
        takerFee: json["taker_fee"] == null
            ? null
            : double.tryParse(json["taker_fee"]),
        tradesCount:
            json["trades_count"] == null ? null : json["trades_count"] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "side": side,
        "ord_type": orderType,
        "price": price,
        "avg_price": avgPrice,
        "state": state,
        "market": market,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "origin_volume": originVolume,
        "remaining_volume": remainingVolume,
        "executed_volume": executedVolume,
        "maker_fee": makerFee,
        "taker_fee": takerFee,
        "trades_count": tradesCount,
      };
}
