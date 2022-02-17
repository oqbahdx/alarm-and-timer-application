import 'package:alert/bloc/cubit.dart';
import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:alert/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/views.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
  static String id = "EventsPage";

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).eventsList;
        var bloc = AppCubit.get(context);
        return Scaffold(
          appBar: appBarBuild(title: 'Events List'),
          backgroundColor: blackC,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Alarms',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: bloc.eventsList.length,
                    itemBuilder: (context, index) => EventListBuild(
                          model: model[index],
                      onDismissed: (onDismissed){
                            setState(() {
                              bloc.deleteEvent(id: model[index].id);
                              bloc.eventsList.removeAt(index);
                            });
                      }, itemKey: Key(model[index].id.toString()),
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}
