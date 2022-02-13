import 'package:alert/bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
   TimeOfDay? newTime;
  pickTime({required BuildContext context,required int hour ,required int minute})async{
      newTime  = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute,),
    );
      emit(PickTimeSuccessState());
  }

  // pickDate({required BuildContext context , required DateTime dateTime})async{
  //
  //     final DateTime? picked = await showDatePicker(
  //         context: context,
  //         initialDate: dateTime,
  //         firstDate: DateTime(2015, 8),
  //         lastDate: DateTime(2101));
  //     if (picked != null && picked != dateTime)
  //       // setState(() {
  //       //   dateTime = picked;
  //       // });
  //
  // }
  createDatabase() async {
    Database database = await openDatabase('alarms.db', version: 1,
        onCreate: (Database db, int version) async {
          print('database has been created successfully');
          await db.execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, event TEXT, date TEXT, time TEXT , status TEXT)');
            print('table has been created successfully');
        },onOpen: (database){
          print('database opened');
        });

  }

}
