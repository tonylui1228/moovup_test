import 'package:dio/dio.dart';

import '../env/app_env.dart';

class RestfulClientRepository {
  final Dio dioClient;

  RestfulClientRepository._(this.dioClient);

  static RestfulClientRepository init() {
    final dio = Dio();
    dio.options.baseUrl = "";
    dio.options.headers.addAll(
        {'Authorization': "Bearer ${AppEnv().apiKey} "});
    final restfulApiClient = RestfulClientRepository._(dio);
    return restfulApiClient;
  }
}
