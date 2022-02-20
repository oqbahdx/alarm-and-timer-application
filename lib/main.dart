import 'package:alert/bloc/cubit.dart';
import 'package:alert/config/theme.dart';
import 'package:alert/screen/events_list.dart';
import 'package:alert/screen/home.dart';
import 'package:alert/screen/timer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase()..getAllEvents(),
      child: MaterialApp(
        theme: ThemeData(
          timePickerTheme: TimePickerColors.timePickerTheme,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => blackC),
              overlayColor: MaterialStateColor.resolveWith((states) => greyC),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: TimerPage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          EventsPage.id: (context) => const EventsPage(),
          TimerPage.id: (context) => const TimerPage(),
        },
      ),
    );
  }
}
