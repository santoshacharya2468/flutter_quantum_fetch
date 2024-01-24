import '../typedef/progress.dart';
import '../response/response.dart';

abstract class IQuantumFetch {
  ///T:return type of response
  ///K:return type of decoder
  Future<HttpResponse<T, K>> getList<T, K>(
    String path, {
    Map<String, String> headers = const {},
    K Function(Map<String, dynamic>)? decoder,
    OnProgress? onProgress,
  });
  Future<HttpResponse<T, T>> get<T>(
    String path, {
    Map<String, String> headers = const {},
    T Function(Map<String, dynamic>)? decoder,
    String? dataNode,
    OnProgress? onProgress,
  });

  Future<HttpResponse<T, T>> post<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    T Function(Map<String, dynamic>)? decoder,
    OnProgress? onProgress,
    String? dataNode,
  });

  Future<HttpResponse<T, T>> delete<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    T Function(Map<String, dynamic>)? decoder,
    OnProgress? onProgress,
  });

  Future<HttpResponse<T, K>> postAndGetList<T, K>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    K Function(Map<String, dynamic>)? decoder,
    String? dataNode,
    OnProgress? onProgress,
  });
  Future<HttpResponse<T, T>> patch<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      T Function(Map<String, dynamic>)? decoder,
      OnProgress? onProgress,
      String? dataNode});

  Future<HttpResponse<T, K>> patchAndGetList<T, K>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      K Function(Map<String, dynamic>)? decoder,
      OnProgress? onProgress,
      String? dataNode});

  Future<Map<String, String>> getDefaultHeaders();
}
