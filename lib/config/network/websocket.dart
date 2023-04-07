// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import '../../data/data.dart';

class Websocket {
  late IOWebSocketChannel channel;
  StreamController streamController = StreamController();
  final String _baseUrl = Environment.getWSBaseUrl();
  var websocketConected = false;
  bool loading = false;
  bool timeout = false;
  static final Websocket instance = Websocket();

  void onInit() {
    streamController = StreamController.broadcast();
    connectToWebSocket();
  }

  void connectToWebSocket() async {
    final String wsURL = '$_baseUrl/?stream=global.tickers';
    channel = IOWebSocketChannel.connect(wsURL);
    channel.stream.listen((event) {
      streamController.add(event);
    }, onError: (e) async {
      debugPrint('Error while connecting websocket, Reconnecting...');
      await Future.delayed(const Duration(seconds: 3));
      connectToWebSocket();
    }, onDone: () async {
      debugPrint('Reconnecting websocket...');
      await Future.delayed(const Duration(seconds: 3));
      connectToWebSocket();
    }, cancelOnError: true);
  }

  Future<void> subscribeOrderBookInc(FormatedMarket market) async {
    channel.sink.add(json.encode({
      "event": "subscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  Future<void> unSubscribeOrderBookInc(FormatedMarket market) async {
    channel.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [
        '${market.id}.ob-inc',
      ]
    }));
  }

  Future<void> subscribeKline(FormatedMarket market, String timeValue) async {
    channel.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['${market.id}.kline-$timeValue']
    }));
  }

  Future<void> unSubscribeKline(FormatedMarket market, String timeValue) async {
    channel.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['${market.id}.kline-$timeValue']
    }));
  }

  Future<void> subscribeOrder() async {
    channel.sink.add(json.encode({
      "event": "subscribe",
      "streams": ['order']
    }));
  }

  Future<void> unSubscribeOrder() async {
    channel.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": ['order']
    }));
  }

  streamsBuilder(
      bool withAuth, FormatedMarket? market, bool incrementalOrderBook) {
    var streams = ['global.tickers'];
    if (withAuth) {
      streams = [
        ...streams,
        'order',
        'trade',
      ];
    }
    if (market != null) {
      streams = [
        ...streams,
        ...(marketStreams(market, incrementalOrderBook)['channels']),
      ];
    }

    return streams;
  }

  dynamic marketStreams(FormatedMarket market, incrementalOrderBook) {
    var channels = [
      '${market.id}.trades',
    ];

    if (incrementalOrderBook) {
      return {
        'channels': [
          ...channels,
          '${market.id}.ob-inc',
        ],
      };
    }

    return {
      'channels': [
        ...channels,
        '${market.id}.update',
      ],
    };
  }

  String generateSocketURI(String url, streams) {
    var streamsURL = '';
    for (int i = 0; i < streams.length; i++) {
      streamsURL += (i == 0) ? streams[i] : '&stream=' + streams[i];
    }
    return '$url/?stream=$streamsURL';
  }

  void onClose() {
    channel.sink.close();
  }
}
