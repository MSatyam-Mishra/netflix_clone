import 'package:dio/dio.dart';

import '../api_value.dart';

class DioClinet {
  Dio? dio;
  static DioClinet? _instance;
  Map<String, dynamic> defaultHEADERS = {"Content-Type": "application/json"};

  DioClinet._internal() {
    dio = Dio();
    dio?.options.baseUrl = ApiValue.url;
    dio?.options.headers = defaultHEADERS;
  }

  static DioClinet get instance {
    _instance ??= DioClinet._internal();
    return _instance!;
  }
}
