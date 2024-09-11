import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:moovup_test_mobile/env/app_env.dart';
import 'package:moovup_test_mobile/repository/restful_client_repository.dart';
import 'package:moovup_test_mobile/util/json_util.dart';

import '../model/dto/person_dto.dart';

class PeopleRepository {
  final RestfulClientRepository restfulClientRepository;

  PeopleRepository(this.restfulClientRepository);

  Future<BuiltList<PersonDto>> getList({
    CancelToken? cancelToken,
  }) async {
    try {
      Response response = await restfulClientRepository.dioClient.get(
        "${AppEnv().serverUrl}-xdNcNKYtTFG/data",
        cancelToken: cancelToken,
      );
      return JsonUtil.fromJsonListToList(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
