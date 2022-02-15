import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color blackC = const Color(0XFF181B1E);
Color greenC = const Color(0XFF02DC73);
Color darkGreyC = const Color(0XFF35373A);
Color redC = const Color(0XFFD20000);
Color greyC = const Color(0XFFC6C7C8);
Color watchC = const Color(0XFF212428);

TextStyle appBarStyle = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 25,
  color: Colors.white,
);
class TimePickerColors{
 static final TimePickerThemeData timePickerTheme = TimePickerThemeData(
    backgroundColor: greyC,
    hourMinuteShape:  const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: Colors.white54, width: 4),
    ),
    dayPeriodBorderSide:  const BorderSide(color: Colors.white54, width: 4),
    dayPeriodColor:MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected) ? blackC : greyC),
    hourMinuteTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.white : blackC),
    shape:  RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      side: BorderSide(color: blackC, width: 4),
    ),
    dayPeriodTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? Colors.white : blackC),

    hourMinuteColor: MaterialStateColor.resolveWith((states) =>
    states.contains(MaterialState.selected) ? blackC : greyC),

    dialHandColor: greyC,
    dialBackgroundColor: blackC,
    hourMinuteTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    dayPeriodTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    helpTextStyle:
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: blackC),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      contentPadding: EdgeInsets.all(0),
    ),
    dialTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected) ? blackC : Colors.white),
    entryModeIconColor: blackC,

  );

}
