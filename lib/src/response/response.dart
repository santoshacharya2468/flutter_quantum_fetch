import 'package:dio/dio.dart';

class HttpResponse<T, K> {
  T? data;
  int? statusCode;
  String? message;
  bool success;
  HttpResponse({
    this.data,
    this.statusCode,
    this.message,
    required this.success,
  });
  factory HttpResponse.fromDioResponse(Response response,
      K Function(Map<String, dynamic>) decoder, String? rootNode) {
    final json = response.data;
    T? data;
    final ok = json['ok'] as bool? ?? false;
    final payloadData = rootNode == null ? json : json[rootNode];
    if (ok) {
      if (T == List<K>) {
        data = (payloadData as List)
            .map((e) => decoder(e as Map<String, dynamic>))
            .toList() as T;
      } else {
        data = decoder(payloadData as Map<String, dynamic>) as T;
      }
    }
    return HttpResponse<T, K>(
        data: data,
        statusCode: response.statusCode,
        message: errorMessageDecoder(json),
        success: json['ok'] as bool? ?? false);
  }
}

String? errorMessageDecoder(Map<String, dynamic> json) {
  final message = json['message'];
  final ok = json['ok'] as bool? ?? false;
  if (message is String) {
    return message;
  } else if (message is List) {
    return message
        .map((e) => e is Map<String, dynamic> ? e['message'] : e)
        .join(",");
  }
  return ok ? null : 'something went wrong ';
}
