import 'dart:async';
import 'dart:convert';
import 'package:pos_wiz_tech/core/developer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../features/auth/data/data_source/auth_local_data_source.dart';

class SocketService {
  final AuthLocalDataSource authLocalDataSource;
  WebSocketChannel? _channel;
  final _orderUpdatesController = StreamController<dynamic>.broadcast();
  Stream<dynamic> get orderUpdates => _orderUpdatesController.stream;
  SocketService({required this.authLocalDataSource});



  Future<void> connect(String token, int userId) async {

    final token = authLocalDataSource.getToken();
    final userId = authLocalDataSource.getUserData()!.id;

    if (token == null) return;
    final wsUrl = Uri.parse(
        'wss://pos.wiz-tech.co/app/meta-rest-key-2024?protocol=7&client=js&version=8.3.0&flash=false'
    );


    try {
      _channel = WebSocketChannel.connect(wsUrl);
      await _channel!.ready;


      _channel!.stream.listen((message) {
        _handleMessage(message, token, userId);
      }, onError: (error) => AppLogger.error("Socket Error: $error"),
          onDone: () =>  AppLogger.error("Socket Closed"));

    } catch (e) {
      AppLogger.error("Connection failed: $e");
    }
  }

  void _handleMessage(String message, String token, int userId) {
    final data = jsonDecode(message);
    final event = data['event'];

    if (event == 'pusher:connection_established') {
      _subscribeToChannel('orders');
      _subscribeToChannel('private-App.Models.User.$userId', auth: token);
    }

    if (event == '.order.updated' || event == '.order.added') {
      AppLogger.info("تحديث جديد للطلبات وصل: ${data['data']}");
      final orderData = jsonDecode(data['data']);
      _orderUpdatesController.add(orderData);
    }
  }

  void _subscribeToChannel(String channelName, {String? auth}) {
    final subscribeMsg = {
      "event": "pusher:subscribe",
      "data": {
        "channel": channelName,
        if (auth != null) "auth": auth,
      }
    };
    _channel!.sink.add(jsonEncode(subscribeMsg));
  }

  void disconnect() {
    _channel?.sink.close();
  }
}