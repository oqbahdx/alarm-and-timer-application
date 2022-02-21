import 'dart:typed_data';

import 'package:alert/config/theme.dart';
import 'package:alert/screen/timer_alarm.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/Containers_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);
  static String id = "TimerPage";

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CustomTimerController _controller = CustomTimerController();
  Duration selectedValue = const Duration(
    hours: 0,
    minutes: 0,
  );

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
          const SizedBox(
            height: 15,
          ),
          CustomTimer(
              controller: _controller,
              begin: const Duration(seconds: 5),
              end: const Duration(),
              onChangeState: (CustomTimerState state) {
                if (_controller.state == CustomTimerState.finished) {
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
                text: "Start",
                color: Colors.green,
                onPressed: () => _controller.start(),
              ),
              RoundedButton(
                text: "Pause",
                color: Colors.blue,
                onPressed: () => _controller.pause(),
              ),
              RoundedButton(
                text: "Reset",
                color: Colors.red,
                onPressed: () => _controller.reset(),
              ),
            ],
          )
        ],
      ),
    );
  }
}






