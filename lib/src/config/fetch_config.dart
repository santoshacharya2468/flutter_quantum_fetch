import 'package:dio/dio.dart';
import 'package:quantum_fetch/quantum_fetch.dart';
import 'package:quantum_fetch/src/metadata/pagination_meta_data.dart';

abstract class QuantumFetchConfig {
  String get baseUrl;

  ///field name used when decoding json
  ///like response={data:{id:1,name:foo}} || response={data:[{id:1,name:foo}]}
  ///put null i'r [ JsonResponseNode(null)] if your response is not in this format. Like response={"id":1,"name":"foo"}|| response=[{"id":1,"name":"foo"}]
  JsonResponseNode get dataNode => JsonResponseNode("data");

  ///field name used determine if the response is success or not
  ///like response={success:true,data:{id:1,name:foo}} || response={success:false,data:[{id:1,name:foo}]}
  ///put "" i'e (empty) if your response is not in this format. Like response={"id":1,"name":"foo"}|| response=[{"id":1,"name":"foo"}]  then it will be determined from your http status code
  JsonResponseNode successNode = JsonResponseNode("success");
  int get connectTimeout => 8000;
  int get receiveTimeout => 20000;
  String get contentType => 'application/json';
  Future<String?> get token;
  String get tokenPrefix => 'Bearer ';
  Map<String, String> get headers => {
        'Content-Type': contentType,
      };
  List<Interceptor> get interceptors => [];
  PaginationMetaData get paginationMetaData => PaginationMetaData();
}
