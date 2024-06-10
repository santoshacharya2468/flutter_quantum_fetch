import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
    final type = lookupMimeType(fileName); //
    final fileData = await MultipartFile.fromFile(file.path,
        filename: fileName,
        contentType: MediaType(type!.split('/').first, type.split('/').last));
    return fileData;
  }

  Future<List<MultipartFile>> listFileEncoder(List<File> files) async {
    final uploadedList = <MultipartFile>[];
    for (final file in files) {
      final fileName = file.path.split("/").last;
      final type = lookupMimeType(fileName); //
      final fileData = await MultipartFile.fromFile(file.path,
          filename: fileName,
          contentType: MediaType(type!.split('/').first, type.split('/').last));
      uploadedList.add(fileData);
    }
    return uploadedList;
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
      } else if (value is List<Map>) {
        result[key] = await Future.wait(value.map((e) async =>
            await bodyEncoder(e as Map<String, dynamic>, depth: depth + 1)));
        // await bodyEncoder(value as Map<String, dynamic>, depth: depth + 1);
      } else if (value is File) {
        hasFile = true;
        result[key] = await fileEncoder(value);
      } else if (value is List<File>) {
        hasFile = true;
        result[key] = await listFileEncoder(value);
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
