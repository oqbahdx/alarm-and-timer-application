import 'package:alert/bloc/cubit.dart';
import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../widget/Containers_widget.dart';
import '../widget/text_form_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = "HomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  TextEditingController? eventController;
  GlobalKey<ScaffoldState> _key = GlobalKey();
  bool _open = false;

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
        var bloc = AppCubit.get(context);
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
          body: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                WatchContainer(watchText: '${now.hour}:${now.minute}',
                  watchDate: '${now.day}-${now.month}-${now.year}',),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 160,
                  child: Column(
                    children: [
                      Text(
                        'Mom Birthday',
                        style: TextStyle(color: darkGreyC, fontSize: 20),
                      ),
                      const SizedBox(
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
                        onTap: () async {
                         setState(() {
                           _open = true;
                         });

                        },
                        child: Card(
                          shadowColor: Colors.white24,
                          elevation: 50.0,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                              borderRadius: BorderRadius.circular(15),
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
                ),

              ],
            ),
          ),
          bottomSheet:_open? Builder(
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
                        ?  PickContainer(
                      text: 'SELECT THE TIME',
                      onTap: (){
                        bloc.pickTime(context: context, hour: now.hour,
                            minute: now.minute);
                      },
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          PickContainer(
                            text:
                            '${AppCubit.get(context).newTime?.format(context)}', onTap: () {

                          },),
                          DeleteIcon(
                            onTap: () {
                              setState(() {
                                AppCubit.get(context).newTime = null;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppCubit.get(context).newDate == null
                        ?  PickContainer(
                      text: 'SELECT THE DATE',
                      onTap: (){
                        bloc.pickDate(context: context, dateTime: now);
                      },
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          PickContainer(
                            text:
                            '${bloc.newDate?.day.toString()}-${bloc.newDate?.month.toString()}-${bloc.newDate?.year.toString()}', onTap: () {  },
                          ),
                          DeleteIcon(onTap: () {
                            setState(() {
                              bloc.newDate = null;
                            });
                          },),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormBuild(eventController: eventController,)
                  ],
                ),
              );
            },
          ):Container(height: 0.0,),
           floatingActionButton:_open? FloatingActionButton(
            onPressed: (){
              if(bloc.newDate==null ){
                Fluttertoast.showToast(msg: 'please fill all fields');
              }else if(bloc.newTime==null){
                Fluttertoast.showToast(msg: 'please fill all fields');
              }else if(eventController?.text == null){
                Fluttertoast.showToast(msg: 'please fill all fields');
              }else{
                setState(() {
                  _open =false;
                });
              }

            },
            backgroundColor: blackC,
            child:  Icon(Icons.save,size: 30,color: greyC,),
          ):null,
        );
      },
    );
  }
}
