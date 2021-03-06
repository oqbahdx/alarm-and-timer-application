import 'package:flutter/material.dart';

import '../config/theme.dart';

class PickContainer extends StatefulWidget {
  const PickContainer({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final Function() onTap;

  @override
  _PickContainerState createState() => _PickContainerState();
}

class _PickContainerState extends State<PickContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ),
    );
  }
}

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({Key? key, required this.onTap}) : super(key: key);
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 15,
      child: IconButton(
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: onTap,
      ),
    );
  }
}

class WatchContainer extends StatelessWidget {
  const WatchContainer(
      {Key? key,
      required this.dayText,
      required this.watchDate,
      required this.watchText,
      required this.alarm})
      : super(key: key);
  final String watchDate;
  final String watchText;
  final String dayText;
  final Widget alarm;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50.0,
      color: watchC,
      shadowColor: Colors.white24,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
            color: blackC, borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                dayText,
                style: TextStyle(
                    fontSize: 15, color: greyC, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                watchDate,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold, color: greyC),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                watchText,
                style: TextStyle(
                    fontSize: 70, color: greyC, fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 10,
              ),
              alarm
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBuild extends StatelessWidget {
  const MenuBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.white24,
      elevation: 50.0,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
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
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color fontColor;
  final void Function()? onPressed;

  RoundedButton(
      {required this.text,
      required this.color,
      this.onPressed,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      color: blackC,
      shadowColor: Colors.white24,
      child: TextButton(
        child: Text(text,
            style: TextStyle(
                color: fontColor, fontSize: 22, fontWeight: FontWeight.bold)),
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
