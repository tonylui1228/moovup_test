import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_service_bloc/flutter_service_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:moovup_test_mobile/widget/people_list_view.dart';

import '../bloc/people_service_bloc.dart';
import '../model/dto/person_dto.dart';
import '../widget/people_map_view.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    context
        .read<PeopleListServiceBloc>()
        .add(const PeopleListServiceRequested());
    _widgetOptions = <Widget>[const PeopleListView(), const PeopleMapView()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("People List"),
        ),
        body: MultiBlocListener(
            listeners: [
              ServiceBlocListener<PeopleListServiceBloc,
                  PeopleListServiceRequested, List<PersonDto>>(
                onLoading: (context, state, event) => SmartDialog.showLoading(),
                onSuccess: (context, state, event, data) => {},
                onFailure: (context, state, event, error) =>
                    {SmartDialog.showToast('Cannot retrieve list')},
                onResponded: (context, state, event) => SmartDialog.dismiss(),
              )
            ],
            child: IndexedStack(
              index: _selectedIndex,
              children: _widgetOptions,
            )),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
