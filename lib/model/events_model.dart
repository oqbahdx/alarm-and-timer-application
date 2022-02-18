class EventsModel{
  int? id;
  String? event;
  String? date;
  String? time;
  String? status;

  EventsModel(this.id, this.event, this.date, this.time,this.status);
   EventsModel.fromJson(Map<dynamic,dynamic>json){
    id = json['id'];
    event = json['event'];
    date = json['date'];
    time = json['time'];
    status = json['status'];

  }
}