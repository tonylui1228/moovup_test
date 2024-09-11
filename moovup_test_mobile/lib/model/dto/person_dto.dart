library person_dto;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';
import 'location_dto.dart';
import 'name_dto.dart';

part 'person_dto.g.dart';

abstract class PersonDto implements Built<PersonDto, PersonDtoBuilder> {
  PersonDto._();

  factory PersonDto([updates(PersonDtoBuilder b)]) = _$PersonDto;

  @BuiltValueField(wireName: '_id')
  String get id;

  @BuiltValueField(wireName: 'name')
  NameDto get name;

  @BuiltValueField(wireName: 'email')
  String get email;

  @BuiltValueField(wireName: 'picture')
  String get picture;

  @BuiltValueField(wireName: 'location')
  LocationDto get location;

  String toJson() {
    return json.encode(serializers.serializeWith(PersonDto.serializer, this));
  }

  static PersonDto fromJson(String jsonString) {
    return serializers.deserializeWith(
        PersonDto.serializer, json.decode(jsonString))!;
  }

  static Serializer<PersonDto> get serializer => _$personDtoSerializer;
}
