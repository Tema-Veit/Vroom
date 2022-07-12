import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:vroom/bloc/trip_bloc/trip_bloc.dart';
import 'package:vroom/screens/login/login_screen.dart';

import 'package:vroom/simple_bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc/login_bloc.dart';
import 'bloc/search_ticket_bloc/search_ticket_bloc.dart';

import 'util/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchTicketBloc()..add(InitialTicket()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => TripBloc()..add(InitialActiveTrip()),
        ),
      ],
      child: MaterialApp(
        title: 'Vroom',
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.routeName,
        routes: routes,
      ),
    );
  }
}
