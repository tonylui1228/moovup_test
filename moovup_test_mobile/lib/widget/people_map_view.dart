import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_service_bloc/flutter_service_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test_mobile/bloc/people_service_bloc.dart';
import 'package:moovup_test_mobile/util/map_util.dart';
import 'package:moovup_test_mobile/util/model_util.dart';

import '../model/dto/person_dto.dart';

class PeopleMapView extends StatefulWidget {
  const PeopleMapView({super.key});

  @override
  State<PeopleMapView> createState() => PeopleMapViewState();
}

class PeopleMapViewState extends State<PeopleMapView> {
  static const CameraPosition _defaultCamera = CameraPosition(
    target: LatLng(22.3193, 114.1694),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _allMarkers = {};
  PersonDto? _selectedPerson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ServiceBlocBuilder<PeopleListServiceBloc,
          PeopleListServiceRequested, List<PersonDto>>(
        onSuccess: (context, state, event, data) {
          if (_allMarkers.isEmpty) {
            _updateMarkers(data, Theme.of(context).textTheme.bodyLarge);
          }
          return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _defaultCamera,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                controller.moveCamera(
                  CameraUpdate.newLatLngBounds(
                    _findBounds(data),
                    10.0,
                  ),
                );
              },
              markers: _allMarkers);
        },
      ),
    );
  }

  LatLngBounds _findBounds(List<PersonDto> peopleDtoList) {
    List<LatLng> latLngList = peopleDtoList
        .where((p) => p.locationLatLng != null)
        .map((p) => p.locationLatLng!)
        .toList();
    return MapUtils.boundsFromLatLngList(latLngList);
  }

  Future<void> _updateMarkers(
      List<PersonDto> peopleDtoList, TextStyle? titleTextStyle) async {
    _allMarkers = await Stream.fromIterable(
            peopleDtoList.where((e) => e.locationLatLng != null))
        .asyncMap((personDto) async =>
            _createMarker(personDto, titleTextStyle, false))
        .toSet();
    setState(() {});
  }

  Future<void> _onPersonLabelSelected(
      PersonDto personDto, TextStyle? titleTextStyle) async {
    if (_selectedPerson != null) {
      _allMarkers.removeWhere(
          (element) => element.markerId == MarkerId(_selectedPerson!.id));
      Marker oldMarker =
          await _createMarker(_selectedPerson!, titleTextStyle, false);
      _allMarkers.add(oldMarker);
    }
    Marker marker = await _createMarker(personDto, titleTextStyle, true);
    _allMarkers.add(marker);

    _selectedPerson = personDto;
    setState(() {});
  }

  Future<Marker> _createMarker(
      PersonDto personDto, TextStyle? titleTextStyle, bool includeTitle) async {
    BitmapDescriptor bitmapDescriptor = await MapUtils.createMarkerBitmap(
        personDto.fullName, titleTextStyle, includeTitle);
    return Marker(
        icon: bitmapDescriptor,
        markerId: MarkerId(personDto.id),
        position:
            LatLng(personDto.location.latitude!, personDto.location.longitude!),
        onTap: () => _onPersonLabelSelected(personDto, titleTextStyle));
  }
}
