import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';
import 'api_consumer.dart';

class HttpConsumer extends ApiConsumer {
  final http.Client client;
  final String baseUrl = "https://your-api-url.com/"; // ضع الرابط الأساسي هنا

  HttpConsumer({required this.client});

  @override
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    final uri = Uri.parse("$baseUrl$path").replace(queryParameters: queryParameters);

    try {
      final response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: "Connection Error: ${e.toString()}");
    }
  }

  @override
  Future<dynamic> post(String path, {Object? body, Map<String, dynamic>? queryParameters}) async {
    final uri = Uri.parse("$baseUrl$path").replace(queryParameters: queryParameters);

    try {
      final response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      return _handleResponse(response);
    } catch (e) {
      throw ServerException(message: "Connection Error: ${e.toString()}");
    }
  }

  // ميثود خاصة لفحص الـ Status Code
  dynamic _handleResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    } else {
      // هان بنطلع الرسالة اللي جاية من السيرفر إذا في خطأ
      throw ServerException(message: responseBody['message'] ?? "Status Code: ${response.statusCode}");
    }
  }
}