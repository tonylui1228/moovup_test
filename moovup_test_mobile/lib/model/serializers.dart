// serializers.dart

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'dto/location_dto.dart';
import 'dto/name_dto.dart';
import 'dto/person_dto.dart';

part 'serializers.g.dart';

@SerializersFor([PersonDto, NameDto, LocationDto])
Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

BuiltList<T> deserializeListOf<T>(dynamic value) {
  final type = FullType(BuiltList, [FullType(T)]);
  if (!serializers.hasBuilder(type)) {
    serializers = (serializers.toBuilder()
          ..addBuilderFactory(type, () => ListBuilder<T>()))
        .build();
  }
  return serializers.deserialize(value, specifiedType: type) as BuiltList<T>;
}
