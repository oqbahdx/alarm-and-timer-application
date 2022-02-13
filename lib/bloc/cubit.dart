import 'package:alert/bloc/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

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
