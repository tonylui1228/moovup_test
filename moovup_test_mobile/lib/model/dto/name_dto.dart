library name;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'name_dto.g.dart';

abstract class NameDto implements Built<NameDto, NameDtoBuilder> {
  NameDto._();

  factory NameDto([updates(NameDtoBuilder b)]) = _$NameDto;

  @BuiltValueField(wireName: 'last')
  String get last;

  @BuiltValueField(wireName: 'first')
  String get first;

  String toJson() {
    return json.encode(serializers.serializeWith(NameDto.serializer, this));
  }

  static NameDto fromJson(String jsonString) {
    return serializers.deserializeWith(
        NameDto.serializer, json.decode(jsonString))!;
  }

  static Serializer<NameDto> get serializer => _$nameDtoSerializer;
}
