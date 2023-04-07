import 'package:crypto_app/config/config.dart';
import 'package:crypto_app/data/data.dart';
import '../../data/model/market/kline.dart';

class MarketRepository {
  final ApiClient client = ApiClient();
  String baseUrl = Environment.getApiBaseUrl();
  String? appVersion = Environment.getApiAppVersion();

  Future<List<Market>> fetchMarket() async {
    try {
      var response = await client.get(Uri.parse(
        '$baseUrl${appVersion!}exchange/public/markets',
      ));
      return marketFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, MarketTicker>> fetchTicker() async {
    try {
      var response = await client.get(
        Uri.parse('$baseUrl${appVersion!}exchange/public/markets/tickers'),
      );
      return marketTickerFromJson(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<List<double>>> fetchKLineData(
      {required String market,
      required String period,
      int? from,
      int? to}) async {
    final response = await client.get(Uri.parse(
        '$baseUrl${appVersion!}exchange/public/markets/$market/k-line?period=$period&time_from=$from&time_to=$to'));
    return kLineFromJson(response.body);
  }
}
