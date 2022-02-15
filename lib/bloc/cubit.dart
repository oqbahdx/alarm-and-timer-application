

import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  TimeOfDay? newTime;

  pickTime(
      {required BuildContext context,
      required int hour,
      required int minute}) async {
    newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: hour,
        minute: minute,
      ),
    );
    emit(PickTimeSuccessState());
  }

  DateTime? newDate;

  pickDate({required BuildContext context, required DateTime dateTime}) async {
    newDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      lastDate: dateTime.add(const Duration(days: 356)),
      firstDate: dateTime,
      builder: (BuildContext context, child){
        return Theme(data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: blackC,
            onPrimary: Colors.white,
            onSurface: blackC,
          ),
          dialogBackgroundColor:greyC,
        ), child: child!);
      }
    );
    emit(PickDateSuccessState());
  }

  clearDate() {
    newDate = null;
    emit(ClearDateState());
  }

  clearTime() {
    newTime = null;
    emit(ClearTimeState());
  }
  Database? database;
  createDatabase() async {
     database = await openDatabase('alarms.db', version: 1,
        onCreate: (Database db, int version) async {
      print('database has been created successfully');
      await db.execute(
          'CREATE TABLE events (id INTEGER PRIMARY KEY, event TEXT, date TEXT, time TEXT , status TEXT)');
      print('table has been created successfully');
    }, onOpen: (database) {
      print('database opened');
    });
  }

  insetData(
      {
      required String? event,
      required String? time,
      required String? date,
      required String status}) async {
      await database?.transaction((txn) async {
       await txn.rawInsert(
          'INSERT INTO events(event, date, time,status) VALUES($event, $time, $date,$status)').then((value){
            print(value.toString());
            emit(InsertDataSuccessState());
       }).catchError((err){
         print( "err : " + err.toString());
         emit(InsertDataErrorState(err.toString()));
       });


    });
  }
}
