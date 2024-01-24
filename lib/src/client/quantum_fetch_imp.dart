import 'package:dio/dio.dart';
import 'package:quantum_fetch/quantum_fetch.dart';

class QuantumFetch implements IQuantumFetch {
  final QuantumFetchConfig config;
  QuantumFetch(this.config);
  @override
  Future<Map<String, String>> getDefaultHeaders() async {
    final token = await config.token;
    return {
      'Authorization': token != null ? '${config.tokenPrefix}$token' : '',
    };
  }

  @override
  Future<HttpResponse<T, T>> get<T>(String path,
          {Map<String, String> headers = const {},
          T Function(Map<String, dynamic>)? decoder,
          OnProgress? onProgress,
          String? dataNode = "data"}) async =>
      getList<T, T>(path,
          headers: headers,
          decoder: decoder,
          dataNode: dataNode,
          onProgress: onProgress);
  @override
  Future<HttpResponse<T, K>> getList<T, K>(String path,
      {Map<String, String> headers = const {},
      K Function(Map<String, dynamic>)? decoder,
      OnProgress? onProgress,
      String? dataNode = "data"}) async {
    final dio = await instance;
    final response = await dio.get(path,
        onReceiveProgress: ((count, total) =>
            onProgress?.call(total ~/ count)));
    return HttpResponse<T, K>.fromDioResponse(
        response, (json) => decoder?.call(json) ?? json as K, dataNode);
  }

  @override
  Future<HttpResponse<T, T>> post<T>(String path,
          {Map<String, String> headers = const {},
          Map<String, dynamic> body = const {},
          T Function(Map<String, dynamic>)? decoder,
          OnProgress? onProgress,
          String? dataNode = "data"}) async =>
      postAndGetList<T, T>(path,
          headers: headers,
          body: body,
          decoder: decoder,
          dataNode: dataNode,
          onProgress: onProgress);
  @override
  Future<HttpResponse<T, K>> postAndGetList<T, K>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      K Function(Map<String, dynamic> p1)? decoder,
      OnProgress? onProgress,
      String? dataNode = "data"}) async {
    final dio = await instance;
    final response = await dio.post(path,
        data: body,
        onSendProgress: ((count, total) =>
            onProgress?.call(calculateProgress(count, total))));
    return HttpResponse<T, K>.fromDioResponse(
        response, (json) => decoder?.call(json) ?? json as K, dataNode);
  }

  @override
  Future<HttpResponse<T, T>> patch<T>(String path,
          {Map<String, String> headers = const {},
          Map<String, dynamic> body = const {},
          T Function(Map<String, dynamic>)? decoder,
          OnProgress? onProgress,
          String? dataNode = "data"}) async =>
      patchAndGetList<T, T>(path,
          headers: headers,
          body: body,
          decoder: decoder,
          dataNode: dataNode,
          onProgress: onProgress);

  @override
  Future<HttpResponse<T, K>> patchAndGetList<T, K>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      K Function(Map<String, dynamic> p1)? decoder,
      OnProgress? onProgress,
      String? dataNode = "data"}) async {
    final dio = await instance;
    final response = await dio.patch(path,
        data: body,
        onSendProgress: ((count, total) => onProgress?.call(total ~/ count)));
    return HttpResponse<T, K>.fromDioResponse(
        response, (json) => decoder?.call(json) ?? json as K, dataNode);
  }

  @override
  Future<HttpResponse<T, T>> delete<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      T Function(Map<String, dynamic>)? decoder,
      OnProgress? onProgress,
      String? dataNode = "data"}) async {
    final dio = await instance;
    final response = await dio.delete(path, data: body);
    final responseBody = response.data ?? {};
    return HttpResponse<T, T>(
      data: decoder?.call(responseBody['data'] as Map<String, dynamic>),
      statusCode: response.statusCode,
      message: responseBody['message'] as String?,
      success: [200, 204].contains(response.statusCode),
    );
  }

  int calculateProgress(int a, int b) {
    return a ~/ b;
  }

  Future<Dio> get instance async {
    return Dio(
      BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          validateStatus: (d) => true,
          headers: await getDefaultHeaders()),
    )..interceptors.addAll([
        cacheIntercepter(),
        LogInterceptor(
            requestBody: true, responseBody: true, responseHeader: false),
        RequestBodyIntercepter(),
        ...config.interceptors
      ]);
  }
}
