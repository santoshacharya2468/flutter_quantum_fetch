import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quantum_fetch/quantum_fetch.dart';
import 'package:quantum_fetch/src/metadata/pagination_meta_data.dart';
import 'package:quantum_fetch/src/response/pagination.dart';

import '../typedef/decoder.dart';

class QuantumFetch extends QuantumFetchImpl {
  QuantumFetch(QuantumFetchConfig config) : super(config);
}

class QuantumFetchImpl implements IQuantumFetch {
  final QuantumFetchConfig config;

  QuantumFetchImpl(this.config);

  @override
  Future<Map<String, String>> getDefaultHeaders() async {
    final token = await config.token;
    return {
      'Authorization': token != null ? '${config.tokenPrefix}$token' : '',
    };
  }

  @override
  Future<APIResponse<T>> get<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response =
          await getRaw(path, onProgress: onProgress, headers: headers);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: e.message,
          rawBody: e);
    }
  }

  @override
  Future<Response<dynamic>> getRaw(String path,
      {OnProgress? onProgress, Map<String, dynamic> headers = const {}}) async {
    final dio = await instance;
    final response = await dio.get(path,
        options: Options(headers: headers),
        onReceiveProgress: ((count, total) =>
            onProgress?.call(total ~/ count)));
    return response;
  }

  @override
  Future<Response<dynamic>> postRaw(String path,
      {OnProgress? onProgress,
      Object data = const {},
      Map<String, dynamic> headers = const {}}) async {
    final dio = await instance;
    final response = await dio.post(path,
        data: data,
        options: Options(headers: headers),
        onSendProgress: ((count, total) => onProgress?.call(total ~/ count)));
    return response;
  }

  Future<Response<dynamic>> patchRaw(String path,
      {OnProgress? onProgress,
      Map<String, dynamic> data = const {},
      Map<String, dynamic> headers = const {}}) async {
    final dio = await instance;
    final response = await dio.patch(path,
        data: data,
        options: Options(headers: headers),
        onSendProgress: ((count, total) => onProgress?.call(total ~/ count)));
    return response;
  }

  Future<Response<dynamic>> putRaw(String path,
      {OnProgress? onProgress,
      Map<String, dynamic> data = const {},
      Map<String, dynamic> headers = const {}}) async {
    final dio = await instance;
    final response = await dio.put(path,
        data: data,
        options: Options(headers: headers),
        onSendProgress: ((count, total) => onProgress?.call(total ~/ count)));
    return response;
  }

  @override
  Future<APIResponseList<T>> getList<T>(
    String path, {
    Map<String, String> headers = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response =
          await getRaw(path, onProgress: onProgress, headers: headers);
      return APIResponseList<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: e.message,
          rawBody: e);
    }
  }

  @override
  Future<APIResponse<T>> post<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await postRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }

  @override
  Future<APIResponse<T>> postFormData<T>(
    String path, {
    Map<String, String> headers = const {},
    required FormData body,
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await postRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }

  @override
  Future<APIResponseList<T>> postAndGetList<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await postRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponseList<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: e.message,
          rawBody: e);
    }
  }

  @override
  Future<APIResponse<T>> patch<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await patchRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }

  @override
  Future<APIResponse<T>> put<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await putRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }

  @override
  Future<APIResponseList<T>> putAndGetList<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await putRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponseList<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: e.message,
          rawBody: e);
    }
  }

  @override
  Future<APIResponseList<T>> patchAndGetList<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final response = await patchRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponseList<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponseList<T>(
          pagination: QuantumFetchPagination.fromJson({}, PaginationMetaData()),
          success: false,
          message: e.message,
          rawBody: e);
    }
  }

  @override
  Future<APIResponse<T>> delete<T>(
    String path, {
    Map<String, String> headers = const {},
    Map<String, dynamic> body = const {},
    required Decoder<T>? decoder,
    OnProgress? onProgress,
    JsonResponseNode? dataNode,
  }) async {
    try {
      final dio = await instance;
      final response = await dio.delete(path, data: body);
      return APIResponse<T>.fromDioResponse(
          response, decoder, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }

  int calculateProgress(int a, int b) {
    return a ~/ b;
  }

  Future<Dio> get instance async {
    return Dio(
      BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: Duration(milliseconds: config.connectTimeout),
          receiveTimeout: Duration(milliseconds: config.receiveTimeout),
          validateStatus: (d) => true,
          headers: await getDefaultHeaders()),
    )..interceptors.addAll([
        // LogInterceptor(
        //     requestBody: true, responseBody: true, responseHeader: false),
        RequestBodyIntercepter(),
        PrettyDioLogger(
            requestHeader: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
        ...config.interceptors,
        cacheIntercepter(),
      ]);
  }

  @override
  Future<APIResponse<T>> upload<T>(String path,
      {Map<String, String> headers = const {},
      Map<String, dynamic> body = const {},
      T Function(Map<String, dynamic> p1)? decoder,
      OnProgress? onProgress,
      JsonResponseNode? dataNode}) async {
    try {
      final response = await postRaw(path,
          data: body, headers: headers, onProgress: onProgress);
      return APIResponse<T>.fromDioResponse(response,
          (json) => decoder?.call(json) ?? json as T, dataNode, config);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return APIResponse<T>(
          success: false,
          message: "Connection timed out",
          rawBody: e,
        );
      }
      return APIResponse<T>(success: false, message: e.message, rawBody: e);
    }
  }
}
