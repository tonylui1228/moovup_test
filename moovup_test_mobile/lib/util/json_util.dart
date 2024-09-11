import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

import '../model/serializers.dart';

class JsonUtil {
  static BuiltList<T> fromJsonListToList<T>(dynamic json) {
    final type = FullType(BuiltList, [FullType(T)]);
    if (!serializers.hasBuilder(type)) {
      serializers = (serializers.toBuilder()
            ..addBuilderFactory(type, () => ListBuilder<T>()))
          .build();
    }
    return serializers.deserialize(json, specifiedType: type) as BuiltList<T>;
  }
}
