import 'package:dio/dio.dart';

abstract class QuantumFetchConfig {
  String get baseUrl;
  int connectTimeout = 8000;
  String contentType = 'application/json';
  Future<String?> get token;
  String tokenPrefix = 'Bearer ';
  Map<String, String> get headers => {
        'Content-Type': contentType,
      };
  List<Interceptor> get interceptors;
}
