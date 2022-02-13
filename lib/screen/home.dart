import 'package:alert/bloc/cubit.dart';
import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  var formatter = DateFormat('EEEE');
  TimeOfDay day = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
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
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Card(
                  elevation: 50.0,
                  color: watchC,
                  shadowColor: Colors.white24,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100)),
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                        color: blackC,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sunday",
                            style: TextStyle(fontSize: 15, color: darkGreyC),
                          ),
                          Text(
                            '${now.month}-${now.day}-${now.year}',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: greyC),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            '${now.hour - 12} : ${now.minute}',
                            style: TextStyle(
                                fontSize: 70,
                                color: greyC,
                                fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '09:00',
                            style: TextStyle(
                              fontSize: 15,
                              color: greyC,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.alarm,
                            color: redC,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 160,
                  child: Column(
                    children: [
                      Text(
                        'Mom Birthday',
                        style: TextStyle(color: darkGreyC, fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                '14',
                                style: TextStyle(
                                    color: greyC,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Days',
                                style:
                                    TextStyle(color: darkGreyC, fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '15',
                                style: TextStyle(
                                    color: greyC,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hours',
                                style:
                                    TextStyle(color: darkGreyC, fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '35',
                                style: TextStyle(
                                    color: greyC,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Mins',
                                style:
                                    TextStyle(color: darkGreyC, fontSize: 20),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '15',
                                style: TextStyle(
                                    color: greyC,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Sec',
                                style:
                                    TextStyle(color: darkGreyC, fontSize: 20),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
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
                        onTap: () async {},
                        child: Card(
                          shadowColor: Colors.white24,
                          elevation: 50.0,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Container(
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: greyC,
                                size: 50,
                              ),
                            ),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: blackC,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.menu,
                        color: greyC,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Builder(
            builder: (BuildContext context) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: blackC,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    AppCubit.get(context).newTime == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                AppCubit.get(context).pickTime(
                                    context: context,
                                    hour: now.hour,
                                    minute: now.minute);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'SELECT THE TIME',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Time : ${AppCubit.get(context).newTime!.format(context).toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
