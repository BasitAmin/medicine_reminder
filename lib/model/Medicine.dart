import 'dart:math';

class Medicine{
  int id;
  String name;
  String startDate;
  String endDate;
  String time;
  String type;

  Medicine(this.id, this.name, this.startDate, this.endDate, this.time,this.type);

  Medicine.fromMap(Map<String, dynamic> map) {
    this.id = map['_id'];
    this.name = map['name'];
    this.time = map['time'];
    this.type = map['type'];
    this.startDate = map['startDate'];
    this.endDate = map['endDate'];


  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': this.id,
      'title': this.name,
      'time': this.time,
      'type': this.type,
      'startDate': this.startDate,
      'endDate': this.endDate,
    };
  }
}
