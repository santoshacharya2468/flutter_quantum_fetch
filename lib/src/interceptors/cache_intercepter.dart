import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

final cacheStore = MemCacheStore(maxSize: 10485760, maxEntrySize: 1048576);
final cacheOptions = CacheOptions(
  store: cacheStore,
  hitCacheOnErrorExcept: [], // for offline behaviour
);

Interceptor cacheIntercepter() {
  return DioCacheInterceptor(options: cacheOptions);
}
