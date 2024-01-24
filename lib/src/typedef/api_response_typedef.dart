import 'package:quantum_fetch/quantum_fetch.dart';

typedef APIResponse<T> = HttpResponse<T, T>;

typedef APIResponseList<T> = HttpResponse<List<T>, T>;
