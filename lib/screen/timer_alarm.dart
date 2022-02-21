import 'package:alert/bloc/cubit.dart';
import 'package:alert/config/theme.dart';
import 'package:flutter/material.dart';

class TimerAlarmPage extends StatefulWidget {
  const TimerAlarmPage({Key? key}) : super(key: key);

  @override
  _TimerAlarmPageState createState() => _TimerAlarmPageState();
}

class _TimerAlarmPageState extends State<TimerAlarmPage> {
  @override
  void initState() {

    super.initState();
    AppCubit.get(context).playRing();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackC,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  Text(
              'Timer Is Finished',
              style: TextStyle(
                  color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: (){
                AppCubit.get(context).stopRing();
                Navigator.of(context).pop();
              },
              child: Container(
                height: 110,
                width: 110,
                child: const Center(
                  child:  Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: redC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
