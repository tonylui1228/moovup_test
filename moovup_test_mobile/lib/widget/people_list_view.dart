import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_service_bloc/flutter_service_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:moovup_test_mobile/bloc/people_service_bloc.dart';
import 'package:moovup_test_mobile/model/dto/person_dto.dart';
import 'package:moovup_test_mobile/page/person_detail_page.dart';
import 'package:moovup_test_mobile/util/model_util.dart';

import '../const/style.dart';

class PeopleListView extends StatefulWidget {
  const PeopleListView({super.key});

  @override
  State<PeopleListView> createState() => PeopleListViewState();
}

class PeopleListViewState extends State<PeopleListView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          context
              .read<PeopleListServiceBloc>()
              .add(const PeopleListServiceRequested());
        },
        child: ServiceBlocBuilder<PeopleListServiceBloc,
                PeopleListServiceRequested, List<PersonDto>>(
            // Dummy view to make RefreshIndicator work on failure request
            fallback: ListView.separated(
              itemBuilder: (context, index) => const SizedBox(),
              separatorBuilder: (context, index) => const SizedBox(),
              itemCount: 0,
            ),
            onSuccess: (context, state, event, data) => ListView.separated(
                itemBuilder: (context, index) =>
                    PeopleListTile(personDto: data[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: defaultPadding,
                    ),
                itemCount: data.length)));
  }
}

class PeopleListTile extends StatelessWidget {
  final PersonDto personDto;

  const PeopleListTile({super.key, required this.personDto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _goToPersonDetailPage(context),
        child: Card(
            margin: defaultLeftRightPadding,
            child: Padding(
                padding: defaultAllEdgePadding,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: userIconSize,
                        height: userIconSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.network(personDto.picture).image,
                              fit: BoxFit.cover),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(personDto.fullName,
                          style: Theme.of(context).textTheme.bodyLarge)
                    ]))));
  }

  void _goToPersonDetailPage(BuildContext context) {
    if (personDto.locationLatLng == null) {
      SmartDialog.showToast(
        "No location found for ${personDto.fullName}",
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PersonDetailPage(personDto: personDto)),
    );
  }
}
