library location;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'location_dto.g.dart';

abstract class LocationDto implements Built<LocationDto, LocationDtoBuilder> {
  LocationDto._();

  factory LocationDto([updates(LocationDtoBuilder b)]) = _$LocationDto;

  @BuiltValueField(wireName: 'latitude')
  double? get latitude;

  @BuiltValueField(wireName: 'longitude')
  double? get longitude;

  String toJson() {
    return json.encode(serializers.serializeWith(LocationDto.serializer, this));
  }

  static LocationDto fromJson(String jsonString) {
    return serializers.deserializeWith(
        LocationDto.serializer, json.decode(jsonString))!;
  }

  static Serializer<LocationDto> get serializer => _$locationDtoSerializer;
}
