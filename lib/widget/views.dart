import 'package:alert/bloc/cubit.dart';
import 'package:alert/model/events_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/theme.dart';

class ColumnBuild extends StatefulWidget {
  const ColumnBuild({Key? key}) : super(key: key);

  @override
  _ColumnBuildState createState() => _ColumnBuildState();
}

class _ColumnBuildState extends State<ColumnBuild> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        textBuild(txt: 'Mom Birthday', color: greyC, size: 20),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                textBuild(txt: '14', color: greyC, size: 40),
                textBuild(txt: 'Days', color: greyC, size: 20),
              ],
            ),
            Column(
              children: [
                textBuild(txt: '15', color: greyC, size: 40),
                textBuild(txt: 'Hours', color: greyC, size: 20),
              ],
            ),
            Column(
              children: [
                textBuild(txt: '35', color: greyC, size: 40),
                textBuild(txt: 'Mins', color: greyC, size: 20),
              ],
            ),
            Column(
              children: [
                textBuild(txt: '15', color: greyC, size: 40),
                textBuild(txt: 'Sec', color: greyC, size: 20),
              ],
            ),
          ],
        )
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
            Icon(Icons.delete,size: 50,color: Colors.white,),
            Icon(Icons.delete,size: 50,color: Colors.white,)
          ],),
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
