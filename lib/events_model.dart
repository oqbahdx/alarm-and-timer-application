class EventsModel{
  int? id;
  String? event;
  String? date;
  String? time;
 late bool status;

  EventsModel(this.id, this.event, this.date, this.time,this.status);
   EventsModel.fromJson(Map<dynamic,dynamic>json){
    id = json['id'];
    event = json['event'];
    time = json['time'];

  }
}