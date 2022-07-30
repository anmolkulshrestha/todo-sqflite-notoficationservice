import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled21/controller/taskcontroller.dart';
import 'package:untitled21/inputfield.dart';
import 'package:untitled21/mybutton.dart';
import 'package:get/get.dart';

import 'models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskcontroller=Get.put(TaskController());
  TextEditingController titlecontroller= TextEditingController();
  TextEditingController notecontroller= TextEditingController();

  int selectremind=5;
  String selectrepeate='None';
  int selectedcolor=0;
  List<int> remindlist=[5,10,15,20,25];
  List<String> repeatelist=['None','Daily','Weekly','Monthly'];
  DateTime _selecteddate=DateTime.now();
  String _endtime="9:30 PM";
  String _starttime=DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tasks",style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )
              ),),
            SizedBox(height: 20,),
            InputField(widget: null, title: "Title", hint: "Enter Your Title", controller: titlecontroller),
              InputField(widget: null, title: "Note", hint: "Enter Your Note", controller: notecontroller),
              InputField(widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: (){
                          setState(() async{
                            await _getdatefromuser();
                          });
                },
              ), title: "Date", hint:DateFormat.yMd().format(_selecteddate), controller: null),
              Row(
                children: [
                  Expanded(child: InputField(
                    title:"start time" ,
                    hint: _starttime,
                    widget: IconButton(onPressed: (){
                      setState(() async{
                      await  _gettimefromuser(isstarttime: true);
                      });

                    },
                    icon: Icon(Icons.access_time_rounded,
                    color: Colors.grey,),

                    ),
                    controller: null,
                  ),),
                  SizedBox(width: 12,),
                  Expanded(child: InputField(
                    title:"end time" ,
                    hint: _endtime,
                    widget: IconButton(onPressed: () {
                       _gettimefromuser(isstarttime: false);
                    },
                      icon: Icon(Icons.access_time_rounded,
                        color: Colors.grey,),
                    ),
                    controller: null,
                  ))
                ],
              ),
              InputField(widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
underline: Container(height: 0,),
onChanged: (String? newvalue){
                  setState(() {
                    selectremind=int.parse(newvalue!);
                  });
},
items:remindlist.map<DropdownMenuItem<String>>((int value){
  return DropdownMenuItem<String>(
    value: value.toString(),
    child: Text(value.toString()),
  );
}).toList(),
              ), title: "Remind", hint: "$selectremind minutes early", controller: null),




              InputField(widget: DropdownButton(
                icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,),
                iconSize: 32,
                elevation: 4,
                underline: Container(height: 0,),
                onChanged: (String? newvalue){
                  setState(() {
                    selectrepeate=newvalue! ;
                  });
                },
                items:repeatelist.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ), title: "Repeate", hint: "$selectrepeate ", controller: null),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 Text("color"),
                 Wrap(children: List<Widget>.generate(3, (int index){
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                         selectedcolor=index;
                       });
                     },
                     child: Padding(
                       padding: EdgeInsets.only(right: 8.0),
                       child: CircleAvatar(
radius: 14,child: selectedcolor==index?Icon(Icons.done,
                       color: Colors.white,
                       size: 16,):Container(),
                         backgroundColor: index==0?Colors.blue:index==1?Colors.pink:Colors.yellow,
                       ),
                     ),
                   );
                 }),)
               ],
             ),
             MyButton(label: "CreateTask", ontap: ()=>_validatedata())
           ],) ,

          ]),
        ),
      ),
    );
  }
_validatedata() {
if(titlecontroller.text.isNotEmpty&&notecontroller.text.isNotEmpty){
  Get.back();
addtasktodb();
taskcontroller.gettask();


}
else if(titlecontroller.text.isEmpty || notecontroller.text.isEmpty){
  Get.snackbar("Required", "All fields are required",snackPosition: SnackPosition.BOTTOM
  ,backgroundColor: Colors.red,
  icon: Icon(Icons.warning_amber_rounded));

}
}
addtasktodb() async{
    int value=await taskcontroller.addtask(task:Task(
        title: titlecontroller.text.toString(),
        note: notecontroller.text.toString(),
        color: selectedcolor,
        repeate: selectrepeate,
        remind: selectremind,
        starttime: _starttime,
        endtime: _endtime,
        iscompleted: 0,
        date: DateFormat.yMd().format(_selecteddate)
    ));
print("my id is $value");

}
  Future<void> _getdatefromuser() async{
    DateTime? _picker=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate:DateTime(2015), lastDate:DateTime(2023) );
     if(_picker!=null){
       setState(() {
         _selecteddate=_picker;
       });
     }               }

     _gettimefromuser({required bool isstarttime}) async{
    var pickedtime= await _showtimepicker();
    print(pickedtime);
    String formatedtime=pickedtime.format(context);
    print(formatedtime);
    if(pickedtime==null){print("hello hello hello");}
    else if(isstarttime==true){
      setState(() {
        _starttime=formatedtime+" PM";
        print(_starttime);
      });


    }
    else if(isstarttime!=false){
      setState(() {
        _endtime=formatedtime+" PM";
      });


    }
     }
     _showtimepicker(){
    return showTimePicker(initialEntryMode: TimePickerEntryMode.input,context: context, initialTime: TimeOfDay(hour: int.parse(_starttime.split(":")[0]), minute: int.parse(_endtime.split(":")[1].split(" ")[0])));
     }
}
