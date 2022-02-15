import 'package:alert/bloc/cubit.dart';
import 'package:alert/bloc/states.dart';
import 'package:alert/widget/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EventsTest extends StatefulWidget {
  const EventsTest({Key? key}) : super(key: key);
  static String id = "EventsText";

  @override
  _EventsTestState createState() => _EventsTestState();
}

class _EventsTestState extends State<EventsTest> {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state) {},
      builder: (context,state){
        var bloc = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text('Events test'),
            ),
            body: ListView.builder(
                itemCount: bloc.list?.length,
                itemBuilder: (context, index) =>
                const EventListBuild(date: 'date', time: 'time', status: true)));
      },

    );

  }
}
