import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test_mobile/util/map_util.dart';

void main() {
  test("Test boundsFromLatLngList", () async {
    List<LatLng> list = [
      const LatLng(22.37, 113.34),
      const LatLng(22.36, 114.18),
      const LatLng(22.34, 113.45)
    ];
    LatLngBounds latLngBounds = MapUtils.boundsFromLatLngList(list);
    assert(latLngBounds ==
        LatLngBounds(
            southwest: const LatLng(22.34, 113.34),
            northeast: const LatLng(22.37, 114.18)));
  });
}
