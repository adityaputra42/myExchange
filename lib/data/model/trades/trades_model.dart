class TradesModel {
  TradesModel({
    this.amount,
    this.createdAt,
    this.id,
    this.market,
    this.price,
    this.takerType,
    this.total,
  });

  double? amount;
  DateTime? createdAt;
  int? id;
  String? market;
  double? price;
  String? takerType;
  double? total;

  factory TradesModel.fromJson(Map<String, dynamic> json) => TradesModel(
        amount: json["amount"] == null ? null : double.parse(json["amount"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch((json['created_at'])),
        id: json["id"] == null ? null : (json["id"]),
        market: json["market"] == null ? null : json["market"] as String,
        price: json["price"] == null ? null : (json["price"]),
        takerType:
            json["taker_type"] == null ? null : json["taker_type"] as String,
        total: json["total"] == null ? null : double.parse(json["total"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "created_at": createdAt,
        "id": id,
        "market": market,
        "price": price,
        "taker_type": takerType,
        "total": total,
      };
}
