import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/dto/person_dto.dart';

extension PersonDataConvertion on PersonDto {
  LatLng? get locationLatLng {
    if (location.latitude == null || location.longitude == null) {
      return null;
    }
    return LatLng(location.latitude!, location.longitude!);
  }

  String get fullName {
    return '${name.first} ${name.last}';
  }
}
