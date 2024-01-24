import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

class RequestBodyIntercepter extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.data is Map) {
      options.data = await bodyEncoder(options.data as Map<String, dynamic>);
    }
    super.onRequest(options, handler);
  }

  Future<MultipartFile> fileEncoder(File file) async {
    final fileName = file.path.split("/").last;
    final fileData =
        await MultipartFile.fromFile(file.path, filename: fileName);
    return fileData;
  }

  FutureOr<dynamic> bodyEncoder(Map<String, dynamic> body,
      {int depth = 0}) async {
    final Map<String, dynamic> result = {};
    bool hasFile = false;
    for (var key in body.keys) {
      final value = body[key];
      if (value is DateTime) {
        result[key] = value.toIso8601String();
      } else if (value is Map) {
        result[key] =
            await bodyEncoder(value as Map<String, dynamic>, depth: depth + 1);
      } else if (value is File) {
        hasFile = true;
        result[key] = await fileEncoder(value);
      } else {
        result[key] = value;
      }
    }

    if (hasFile && depth == 0) {
      return FormData.fromMap(result);
    }
    return result;
  }
}
