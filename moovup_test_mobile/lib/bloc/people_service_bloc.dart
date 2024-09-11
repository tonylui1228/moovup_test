import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_service_bloc/flutter_service_bloc.dart';
import 'package:moovup_test_mobile/model/dto/person_dto.dart';
import 'package:moovup_test_mobile/repository/people_repository.dart';

class PeopleListServiceRequested extends ServiceRequested {
  const PeopleListServiceRequested();

  @override
  List<Object?> get props => [];
}

class PeopleListServiceBloc
    extends ServiceBloc<PeopleListServiceRequested, List<PersonDto>> {
  PeopleListServiceBloc(this.peopleRepository );

  final PeopleRepository peopleRepository;

  @override
  FutureOr<void> onRequest(
      PeopleListServiceRequested event, Emitter<ServiceState> emit) async {
    try {
      final response = await peopleRepository.getList();
      final responseDtoList = response.toList();
      emit(ServiceLoadSuccess(event: event, data: responseDtoList));
    } catch (error) {
      emit(ServiceLoadFailure(event: event, error: error));
    }
  }
}
