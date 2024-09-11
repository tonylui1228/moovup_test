import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup_test_mobile/model/dto/person_dto.dart';
import 'package:moovup_test_mobile/repository/people_repository.dart';
import 'package:moovup_test_mobile/repository/restful_client_repository.dart';

void main() {
  test("Test People Endpoint API calls", () async {
    final restfulApiClient = await RestfulClientRepository.init();
    final peopleRepository = PeopleRepository(restfulApiClient);

    List<PersonDto> peopleDtoList = (await peopleRepository.getList()).toList();
    assert(peopleDtoList.isNotEmpty);
  });
}
