import 'dart:typed_data';

import 'package:alert/bloc/states.dart';
import 'package:alert/config/theme.dart';
import 'package:alert/model/events_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
        builder: (BuildContext context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: blackC,
                  onPrimary: Colors.white,
                  onSurface: blackC,
                ),
                dialogBackgroundColor: greyC,
              ),
              child: child!);
        });
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
          'CREATE TABLE events (id INTEGER PRIMARY KEY, event TEXT, date Text, time TEXT , status Boolean)');
      print('table has been created successfully');
    }, onOpen: (database) {
      print('database opened');
    });
  }
  Future insetData(
      {required String event,
        required String time,
        required String date,
        required bool status}) async {
    await database?.transaction((txn) async {
      await txn
          .rawInsert('INSERT INTO events (event, date, time,status) VALUES '
          '("$event", "$date", "$time","$status" )')
          .then((value) {
        print("value : " + value.toString());
        emit(InsertDataSuccessState());

      }).catchError((err) {
        if (kDebugMode) {
          print("err : " + err.toString());
          emit(InsertDataErrorState(err.toString()));
        }

      });
    });
  }


  List<Map>? list;
  List<EventsModel> eventsList = [];

  getAllEvents() async {
    eventsList = [];
    list = await database?.rawQuery('SELECT * FROM events').then((value) {
      for (var element in value) {
        eventsList.add(EventsModel.fromJson(element));
      }
    });
    if (kDebugMode) {
      print(eventsList);
    }
  }

  deleteEvent({int? id}) async {
    await database?.rawDelete("DELETE FROM events WHERE id = $id ").then((value){
      print(value.toString());
      print("id : ${value.toString()} has been deleted successfully");
    }).catchError((err){
      print('failed to delete item');
    });
  }
  updateEvent({String? status,int? id })async{
      await database?.rawUpdate(
        "UPDATE events SET status = '$status' WHERE id = $id ").then((value){
          print('events has been updated successfully');
          getAllEvents();
      }).catchError((err){
        print(err.toString());
      });
  }
  dropTable()async{
    await database?.delete('events').then((value){
      print('table has been deleted');
    });
  }
  String? timeString;
  void getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);

      timeString = formattedDateTime;
      emit(RealTimeWatchState());
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  var now = DateTime.now();
  var endTime ;
  var diff ;


 checkTime({enTime}){
   diff = now.difference(enTime).inDays;
   print(diff);
 }
  DateTime myDate = DateTime. now();
  String? formattedDate ;
  AudioPlayer player = AudioPlayer();
  Future playRing() async {
    String audioasset = "assets/ring.mp3";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
    bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }
  Future stopRing() async {
    int result = await player.stop();
    if (result == 1) {
      //stop success
      print("Sound playing stopped successfully.");
    } else {
      print("Error on while stopping sound.");
    }
  }
}
