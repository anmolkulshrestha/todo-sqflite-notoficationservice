class Task{
  int?  id;
  String? title;
  String? note;
  int? iscompleted;
  String? date;
  String? starttime;
  String? endtime;
  int? color;
  int? remind;
  String? repeate;
  Task({this.id,this.title,this.note,this.iscompleted,this.date,this.starttime,this.endtime,this.color,this.remind,this.repeate});
Task.fromjson(Map<String,dynamic> json){
  id=json['id'];
  title=json['title'];
  note=json['note'];
  endtime=json['endtime'];
  starttime=json['starttime'];
  color=json['color'];
  remind=json['remind'];
  repeate=json['repeate'];
  date=json['date'];
  iscompleted=json['iscompleted'];

}

Map<String,dynamic> tojson(){
  final Map<String,dynamic> data=new Map<String,dynamic>();
  data['id']=this.id;
  data['iscompleted']=this.iscompleted;
  data['title']=this.title;
  data['note']=this.note;
  data['starttime']=this.starttime;
  data['endtime']=this.endtime;
  data['repeate']=this.repeate;
  data['remind']=this.remind;
  data['color']=this.color;
  data['date']=this.date;
  return data;
}
}