import 'dart:typed_data';

import 'package:alert/config/theme.dart';
import 'package:alert/screen/timer_alarm.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widget/Containers_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);
  static String id = "TimerPage";

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CustomTimerController _controller = CustomTimerController();
  Duration selectedValue = const Duration(hours: 0, minutes: 0, seconds: 0);
  bool showTimer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackC,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: blackC,
        title: Text(
          "TIMER",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: greyC),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showTimer == false
              ? Column(
                  children: [
                    CupertinoTheme(
                      data: const CupertinoThemeData(
                        brightness: Brightness.dark,
                      ),
                      child: CupertinoTimerPicker(
                        backgroundColor: blackC,
                        onTimerDurationChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      onTap: () {
                        if (selectedValue.inHours == 0 &&
                            selectedValue.inMinutes == 0 &&
                            selectedValue.inSeconds == 0) {
                          Fluttertoast.showToast(
                              msg: "Please pick a time",
                              textColor: Colors.white,
                              backgroundColor: Colors.red);
                        } else {
                          setState(() {
                            showTimer = true;
                            _controller.start();
                          });
                        }
                      },
                      child: Card(
                        elevation: 20.0,
                        shadowColor: Colors.white24,
                        color: blackC,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: blackC,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 60,
                              color: greyC,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    CustomTimer(
                        controller: _controller,
                        begin: selectedValue,
                        end: const Duration(),
                        onChangeState: (CustomTimerState state) async{
                          if (_controller.state == CustomTimerState.finished) {
                            const androidConfig = FlutterBackgroundAndroidConfig(
                                notificationTitle: "oqbah alarm  app",
                                notificationText: "Background notification for keeping the example app running in the background",
                                notificationImportance: AndroidNotificationImportance.Default,
                                notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'));
                            bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
                            FlutterBackground.enableBackgroundExecution();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TimerAlarmPage()));
                            _controller.reset();
                          }
                        },
                        builder: (remaining) {
                          return Text(
                              "${remaining.hours} : ${remaining.minutes} : ${remaining.seconds}",
                              style: const TextStyle(
                                  fontSize: 35.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold));
                        }),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundedButton(
                          text: "Pause",
                          fontColor: Colors.grey,
                          color: blackC,
                          onPressed: () => _controller.pause(),
                        ),
                        RoundedButton(
                          text: "Resume",
                          fontColor: Colors.teal,
                          color: blackC,
                          onPressed: () => _controller.start(),
                        ),
                        RoundedButton(
                          fontColor: redC,
                          text: "Close",
                          color: blackC,
                          onPressed: () {
                            setState(() {
                              showTimer = false;
                              _controller.reset;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
