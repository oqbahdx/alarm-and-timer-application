import 'package:alert/screen/events_list.dart';
import 'package:alert/screen/home.dart';
import 'package:flutter/material.dart';



void main(){
  runApp(const MyApp());


}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: EventsPage.id,
      routes: {
        HomePage.id:(context)=>const HomePage(),
        EventsPage.id:(context)=>const EventsPage(),
      },
    );
  }
}
