import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:moovup_test_mobile/bloc/people_service_bloc.dart';
import 'package:moovup_test_mobile/page/landing_page.dart';
import 'package:moovup_test_mobile/repository/people_repository.dart';
import 'package:moovup_test_mobile/repository/restful_client_repository.dart';

void main() {
  runApp(const MoovupTestApp());
}

class MoovupTestApp extends StatelessWidget {
  const MoovupTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => RestfulClientRepository.init()),
          RepositoryProvider(
              create: (context) =>
                  PeopleRepository(context.read<RestfulClientRepository>()))
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    PeopleListServiceBloc(context.read<PeopleRepository>()),
              )
            ],
            child: MaterialApp(
              title: 'Moovup test',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const LandingPage(),
              navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
            )));
  }
}
