import 'package:alert/config/theme.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);
  static String id = "TimerPage";

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final CustomTimerController _controller = CustomTimerController();
  Duration selectedValue = Duration(hours:0, minutes: 0,);
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
          CupertinoTimerPicker(
              backgroundColor: Colors.white10,
               mode: CupertinoTimerPickerMode.hm,
              onTimerDurationChanged: (value){

           setState(() {
             selectedValue = value;
             print(selectedValue.toString());
           });
          }),
          const SizedBox(height: 15,),
          CustomTimer(
              controller: _controller,
              begin:  selectedValue,
              end: const Duration(),
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
              )
            ],
          )
        ],
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function()? onPressed;

  RoundedButton({required this.text, required this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text, style: const TextStyle(color: Colors.white)),
      style: TextButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      onPressed: onPressed,
    );
  }
}

