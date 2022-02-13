import 'package:alert/bloc/cubit.dart';
import 'package:alert/screen/events_list.dart';
import 'package:alert/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          EventsPage.id: (context) => const EventsPage(),
        },
      ),
    );
  }
}
