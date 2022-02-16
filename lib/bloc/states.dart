abstract class AppStates {}

class AppInitialState extends AppStates {}

class PickTimeSuccessState extends AppStates{}
class PickDateSuccessState extends AppStates{}
class ClearTimeState extends AppStates{}
class ClearDateState extends AppStates{}
class InsertDataSuccessState extends AppStates{}
class InsertDataLoadingState extends AppStates{}
class InsertDataErrorState extends AppStates{
  late final String error;
  InsertDataErrorState(this.error);
}

class RealTimeWatchState extends AppStates{}