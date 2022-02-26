import 'package:alert/bloc/cubit.dart';
import 'package:alert/model/events_model.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/theme.dart';

class ColumnBuild extends StatefulWidget {
  const ColumnBuild({Key? key, required this.model}) : super(key: key);
  final EventsModel model;

  @override
  _ColumnBuildState createState() => _ColumnBuildState();
}

class _ColumnBuildState extends State<ColumnBuild> {
  final CustomTimerController _controller = CustomTimerController();
  @override
  void initState() {
    super.initState();
    _controller.start();
  }
  @override
  Widget build(BuildContext context) {
    var date1 = DateFormat('dd-MM-yyy hh:mm a')
        .parse(AppCubit.get(context).formattedDate!);
    var date2 = DateFormat('dd-MM-yyy hh:mm a')
        .parse("${widget.model.date} ${widget.model.time}");
    var days = date1.difference(date2).inDays;
    var hours = date1.difference(date2).inHours;
    var minus = date1.difference(date2).inMinutes ;
    var sec = date2.difference(date1).inSeconds  ;
    Duration duration = Duration(
      days: days.abs(),
      hours: (minus/720).abs().toInt(),
      minutes: (minus/720).abs().toInt(),
      seconds: (sec/86400).abs().toInt()
    );
    return Column(
      children: [
        textBuild(txt: widget.model.event.toString(), color: greyC, size: 20),
        const SizedBox(
          height: 30,
        ),
        CustomTimer(
          controller: _controller,
            begin:duration,
            end: const Duration(),
            onChangeState: (CustomTimerState state) {
            if(_controller.state == CustomTimerState.finished){
              AppCubit.get(context).playRing();
            }

            },
            builder: (remaining) {
              return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      textBuild(txt: remaining.days, color: greyC, size: 40),
                      textBuild(txt: 'Days', color: greyC, size: 20),
                    ],
                  ),
                  Column(
                    children: [
                      textBuild(txt:remaining.hours, color: greyC, size: 40),
                      textBuild(txt: 'Hours', color: greyC, size: 20),
                    ],
                  ),
                  Column(
                    children: [
                      textBuild(txt:remaining.minutes, color: greyC, size: 40),
                      textBuild(txt: 'Minus', color: greyC, size: 20),
                    ],
                  ),
                  Column(
                    children: [
                      textBuild(txt:remaining.seconds, color: greyC, size: 40),
                      textBuild(txt: 'Sec', color: greyC, size: 20),
                    ],
                  ),
                ],
              );
            }),

      ],
    );
  }
}

Text textBuild(
    {required String txt, required Color color, required double size}) {
  return Text(
    txt,
    style: textBuildStyle(color: color, size: size),
  );
}

TextStyle textBuildStyle({required Color color, required double size}) {
  return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold);
}

class EventListBuild extends StatefulWidget {
  const EventListBuild({
    Key? key,
    required this.model,
    required this.onDismissed,
    required this.itemKey,
  }) : super(key: key);

  final EventsModel model;
  final Function(DismissDirection)? onDismissed;
  final Key itemKey;

  @override
  _EventListBuildState createState() => _EventListBuildState();
}

class _EventListBuildState extends State<EventListBuild> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Dismissible(
        background: Container(
          color: redC,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(
                Icons.delete,
                size: 50,
                color: Colors.white,
              ),
              Icon(
                Icons.delete,
                size: 50,
                color: Colors.white,
              )
            ],
          ),
        ),
        key: widget.itemKey,
        direction: DismissDirection.horizontal,
        onDismissed: widget.onDismissed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.model.time.toString(),
                  style: TextStyle(
                      color:
                          widget.model.status == 'true' ? Colors.white : greyC,
                      fontSize: 45,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.model.date.toString(),
                  style: TextStyle(
                      color:
                          widget.model.status == 'true' ? Colors.white : greyC,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.model.event.toString(),
                  style: TextStyle(
                      color:
                          widget.model.status == 'true' ? Colors.white : greyC,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CupertinoSwitch(
              thumbColor: widget.model.status == 'true' ? greenC : redC,
              activeColor: greyC,
              trackColor: greyC,
              value: widget.model.status == 'true' ? true : false,
              onChanged: (bool value) {
                setState(() {
                  AppCubit.get(context).updateEvent(
                      status: value ? 'true' : 'false', id: widget.model.id);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
