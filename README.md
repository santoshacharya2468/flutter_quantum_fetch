# quantum_fetch

A module that uses powerful http library [dio](https://pub.dev/packages/dio) for network calls. You can directly start with already [setup project](https://gitlab.com/swivt/initial-flutter-project) or you can configure it the following way in your project.
## Introduction
quantum_fetch is a network module that has been created seperately for easily maintaining code for dio. The usage of this module is pretty simple.

```dart
 class MyFetchConfig implements QuantumFetchConfig {
  @override
  String get baseUrl => 'https://api.github.com';
  @override
  String tokenPrefix = 'Bearer ';
  @override
  Future<String?> get token => Future.value("my_authrization_token");
  @override
  List<Interceptor> get interceptors => [];

  @override
  int connectTimeout = 8000;

  @override
  String contentType = "application/json";

  @override
  Map<String, String> get headers => {"myheader": "myheadervalue"};
}
final fetchConfig = MyFetchConfig();
final quantumClient = QuantumFetch(fetchConfig);
```

 `QuantumFetchConfig` is part of project dependency, from which we use the baseUrl in our `quantum_fetch`.

 ## Basic Usage
```dart
 final  response = await quantumClient.get<User>("/user",decoder: User.fromJson);
  print(response.success);
```


