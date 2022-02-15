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
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getAllEvents();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = AppCubit.get(context);
        var model = bloc.eventsList;
        return Scaffold(
            appBar: AppBar(
              title: const Text('Events test'),
            ),
            body: ListView.builder(
                itemCount: bloc.eventsList.length,
                itemBuilder: (context, index) =>  EventListBuild(
                      model: model[index],
                    )));
      },
    );
  }
}
