import 'package:quantum_fetch/quantum_fetch.dart';

import '../typedef/decoder.dart';

abstract class IQuantumFetch {
  ///T:return type of response
  ///K:return type of decoder
  Future<APIResponseList<T>> getList<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
    JsonResponseNode? dataNode,
    OnProgress? onProgress,
  });
  Future<APIResponse<T>> get<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
    JsonResponseNode? dataNode,
    OnProgress? onProgress,
  });
  Future<Response<dynamic>> getRaw(String path,
      {OnProgress? onProgress, Map<String, dynamic> headers = const {}});

  Future<APIResponse<T>> post<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  });

  Future<Response<dynamic>> postRaw(String path,
      {OnProgress? onProgress,
      Object data = const {},
      Map<String, dynamic> headers = const {}});

  Future<APIResponse<T>> upload<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    T Function(Map<String, dynamic>)? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  });

  Future<APIResponse<T>> delete<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  });

  Future<APIResponseList<T>> postAndGetList<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    JsonResponseNode? dataNode,
    OnProgress? onProgress,
  });
  Future<APIResponse<T>> patch<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      OnProgress? onProgress,
      JsonResponseNode? dataNode});

  Future<APIResponseList<T>> patchAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      OnProgress? onProgress,
      JsonResponseNode? dataNode});
  Future<APIResponse<T>> put<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      OnProgress? onProgress,
      JsonResponseNode? dataNode});

  Future<APIResponseList<T>> putAndGetList<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      required Decoder<T>? decoder,
      OnProgress? onProgress,
      JsonResponseNode? dataNode});

  Future<Map<String, String>> getDefaultHeaders();
}
