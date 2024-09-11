import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test_mobile/model/dto/person_dto.dart';
import 'package:moovup_test_mobile/util/model_util.dart';

import '../const/style.dart';

class PersonDetailPage extends StatelessWidget {
  const PersonDetailPage({super.key, required this.personDto});

  final PersonDto personDto;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(personDto.fullName),
        ),
        child: Column(children: [
          Expanded(
              child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: createInitialCameraPosition(personDto),
                  markers: createMarkers(personDto))),
          Align(
              alignment: Alignment.bottomCenter,
              child: PersonDetailView(personDto: personDto))
        ]));
  }

  CameraPosition createInitialCameraPosition(PersonDto personDto) {
    return CameraPosition(
        target: LatLng(
            personDto.location.latitude!, personDto.location.longitude!), zoom: 15);
  }

  Set<Marker> createMarkers(PersonDto personDto) {
    return {
      Marker(
          markerId: MarkerId(personDto.id),
          position: LatLng(
              personDto.location.latitude!, personDto.location.longitude!))
    };
  }
}

class PersonDetailView extends StatelessWidget {
  final PersonDto personDto;

  const PersonDetailView({super.key, required this.personDto});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        margin: defaultAllEdgePadding,
        width: userIconSize,
        height: userIconSize,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.network(personDto.picture).image, fit: BoxFit.cover),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
      Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(personDto.fullName, style: Theme.of(context).textTheme.bodyLarge),
        Text(personDto.email, style: Theme.of(context).textTheme.bodyMedium)
      ]))
    ]);
  }
}
