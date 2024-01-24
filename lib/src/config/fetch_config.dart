import 'package:dio/dio.dart';
import 'package:quantum_fetch/quantum_fetch.dart';

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

class MyFetchConfig implements QuantumFetchConfig {
  @override
  String get baseUrl => 'https://api.github.com';
  @override
  String tokenPrefix = 'Bearer ';
  @override
  Future<String?> get token => Future.value("my_authrization_token");
  @override
  List<Interceptor> get interceptors => [];

  @override
  int connectTimeout = 8000;

  @override
  String contentType = "application/json";

  @override
  Map<String, String> get headers => {"myheader": "myheadervalue"};
}

final fetchConfig = MyFetchConfig();
final quantumClient = QuantumFetch(fetchConfig);
