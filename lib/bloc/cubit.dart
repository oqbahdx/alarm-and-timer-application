

import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:alert/events_model.dart';
import 'package:flutter/foundation.dart';
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
          'CREATE TABLE events (id INTEGER PRIMARY KEY, event TEXT, date Date, time TEXT , status Boolean)');
      print('table has been created successfully');
    }, onOpen: (database) {
      print('database opened');
    });
  }

 Future insetData(
      {
      required String event,
      required String time,
      required String date,
      required bool status}) async {
      await database?.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO events (event, date, time,status) VALUES '
              '("$event", "$date", "$time","$status" )').then((value){
            if (kDebugMode) {
              print("value : "+value.toString());

            }
            emit(InsertDataSuccessState());
       }).catchError((err){
         if (kDebugMode) {
           print( "err : " + err.toString());
         }
         emit(InsertDataErrorState(err.toString()));
       });


    });


  }
  List<Map>? list;
  List<EventsModel> eventsList = [];
  getAllEvents()async{
    eventsList = [];
     list = await database?.rawQuery('SELECT * FROM events').then((value){
       for (var element in value) {
         eventsList.add(EventsModel.fromJson(element));
       }
     });
    if (kDebugMode) {
      print(eventsList);
    }

  }

  deleteEvent({int? id})async{
    await database?.rawDelete('DELETE FROM events WHERE id = "$id"');
  }
}
