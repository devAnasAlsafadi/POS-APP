import 'package:pos_wiz_tech/core/errors/errors.dart';

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});

  @override
  String toString() => message;

}