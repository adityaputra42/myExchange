import 'dart:convert';

import '../../config/network/api_client.dart';
import '../../data/data.dart';

class TradeRepository {
  ApiClient client = ApiClient();
  final String baseUrl = Environment.getApiBaseUrl();
  final String? appVersion = Environment.getApiAppVersion();
  Future<List<TradesModel>> getTrades(FormatedMarket market) async {
    try {
      var response = await client.get(Uri.parse(
          '$baseUrl${appVersion!}exchange/public/markets/${market.id}/trades'));
      List<TradesModel> trades = [];
      for (final value in jsonDecode(response.body)) {
        trades.add(TradesModel.fromJson(value));
      }
      return trades;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
