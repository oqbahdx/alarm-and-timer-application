import 'dart:async';

import 'package:alert/bloc/cubit.dart';
import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:alert/model/events_model.dart';
import 'package:alert/screen/events_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widget/Containers_widget.dart';
import '../widget/text_form_widget.dart';
import '../widget/views.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  var day;

  TextEditingController eventController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _open = false;

  @override
  void initState() {
    super.initState();
    day = DateFormat('EEEE').format(now);
    AppCubit.get(context).createDatabase();
    AppCubit.get(context).timeString =
        AppCubit.get(context).formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1),
        (Timer t) => AppCubit.get(context).getTime());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertDataSuccessState) {
          Fluttertoast.showToast(
              msg: 'New Alarm Saved', backgroundColor: Colors.teal,fontSize: 20);
        }
      },
      builder: (context, state) {
        var bloc = AppCubit.get(context);
        var model = AppCubit.get(context).eventsList;
        return Scaffold(
          key: _key,
          backgroundColor: blackC,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: blackC,
            centerTitle: true,
            title: Text(
              "Clock",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: greyC),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  WatchContainer(
                    dayText: day.toString(),
                    watchText: '${AppCubit.get(context).timeString}',
                    watchDate: '${now.day}-${now.month}-${now.year}',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                   SizedBox(
                    height: 160,
                    child: model.isNotEmpty?ColumnBuild(model: model[0]): Center(
                      child: Text('No Event Yet',style: TextStyle(
                          color: greyC, fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: greyC,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              _open = true;
                            });
                          },
                          child: const MenuBuild(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const EventsPage()));
                            bloc.getAllEvents();
                          },
                          child: Icon(
                            Icons.menu,
                            color: greyC,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: _open
              ? Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 210,
                      decoration: BoxDecoration(
                        color: blackC,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          AppCubit.get(context).newTime == null
                              ? PickContainer(
                                  text: 'SELECT THE TIME',
                                  onTap: () {
                                    bloc.pickTime(
                                        context: context,
                                        hour: now.hour,
                                        minute: now.minute);
                                  },
                                )
                              : Stack(
                                  children: [
                                    PickContainer(
                                      text:
                                          '${AppCubit.get(context).newTime?.format(context)}',
                                      onTap: () {},
                                    ),
                                    DeleteIcon(
                                      onTap: () {
                                        bloc.clearTime();
                                      },
                                    )
                                  ],
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                          AppCubit.get(context).newDate == null
                              ? PickContainer(
                                  text: 'SELECT THE DATE',
                                  onTap: () {
                                    bloc.pickDate(
                                        context: context, dateTime: now);
                                  },
                                )
                              : Stack(
                                  children: [
                                    PickContainer(
                                      text: '${bloc.newDate?.day.toString()}'
                                          '-${bloc.newDate?.month.toString()}'
                                          '-${bloc.newDate?.year.toString()}',
                                      onTap: () {},
                                    ),
                                    DeleteIcon(
                                      onTap: () {
                                        // setState(() {
                                        //   bloc.newDate = null;
                                        // });
                                        bloc.clearDate();
                                      },
                                    ),
                                  ],
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormBuild(
                            eventController: eventController,
                          )
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  height: 0.0,
                ),
          floatingActionButton: _open
              ? bloc.newTime  == null
                  ? FloatingActionButton(
                      backgroundColor: blackC,
                      onPressed: () {
                        setState(() {
                          _open = false;
                        });
                      },
                      child: Icon(
                        Icons.arrow_downward_sharp,
                        size: 30,
                        color: greyC,
                      ),
                    )
                  : FloatingActionButton(
                      onPressed: () {
                        bloc
                            .insetData(
                                event: eventController.text.toString(),
                                time:
                                    '${bloc.newTime?.format(context).toString()}',
                                date:
                                    '${bloc.newDate?.day}-${bloc.newDate?.month}-${bloc.newDate?.year}',
                                status: true)
                            .then((value) {
                          setState(() {
                            _open = false;
                            bloc.clearTime();
                            bloc.clearDate();
                            eventController.text = '';
                          });
                          AppCubit.get(context).getAllEvents();
                        });
                      },
                      backgroundColor: blackC,
                      child: Icon(
                        Icons.save,
                        size: 30,
                        color: greyC,
                      ),
                    )
              : null,
        );
      },
    );
  }
}
