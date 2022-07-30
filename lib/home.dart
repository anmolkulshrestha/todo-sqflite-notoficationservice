import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:untitled21/Notification_services.dart';
import 'package:untitled21/addtask.dart';
import 'package:untitled21/mybutton.dart';
import 'package:untitled21/themeservices.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:get/get.dart';

import 'TaskTile.dart';
import 'controller/taskcontroller.dart';
import 'models/task.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selecteddate=DateTime.now();
  final TaskController taskcontroller=Get.put(TaskController());
  var notifyhelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyhelper=NotifyHelper();
    notifyhelper.initializeNotification();
    notifyhelper.requestIOSPermissions();
    taskcontroller.gettask();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

leading: GestureDetector(
  onTap: (){
ThemeService().switchTheme();
print(ThemeService().theme);
notifyhelper.displayNotification(title:"hehhe",
    body:'jkfjkjkf');
  },
  child: Icon(Icons.nightlight_round,size: 25,),
),
actions: [
  Icon(Icons.person,size: 25,),
  SizedBox(width: 20,)
],

      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(


          children: [
            _addtaskbar(),
             Container(
               margin: EdgeInsets.symmetric(vertical: 20),
               child: DatePicker(
DateTime.now(),
                 height: 100,
                 width: 80,
                 initialSelectedDate: DateTime.now(),
                 selectionColor: Colors.blue,
                 selectedTextColor: Colors.white,
                 dateTextStyle: GoogleFonts.lato(
                   textStyle: TextStyle(
                       fontSize: 14,
                       fontWeight: FontWeight.w600,
                       color:Colors.grey
                   ),
                 ),
                 onDateChange: (date){
  setState(() {
    _selecteddate=date;
  });
                 },
               ),
             ),
            SizedBox(height: 10,),
            _showtasks(),
          ],
        ),
      ),
    );
  }

   _showtasks() {

    return  Expanded(child: Obx((){

      return ListView.builder(itemCount: taskcontroller.tasklist.length,itemBuilder: (_,index){
Task task =taskcontroller.tasklist[index];
print(task.tojson());
print(taskcontroller.tasklist.length.toString()+"kjsnvjkfnjbnlkfm");

if(task.repeate=='Daily'){
  DateTime date=DateFormat.jm().parse(task.starttime.toString());
  print(date);
  var myTime=DateFormat("HH:mm").format(date);
  print(myTime);
  notifyhelper.scheduledNotification(int.parse(myTime.toString().split(":")[0]),int.parse(myTime.toString().split(":")[1]),task);
  return AnimationConfiguration.staggeredList(position: index,  child: SlideAnimation(
  child: FadeInAnimation(


    child: Row(

      children: [
        GestureDetector(
          onTap: (){
            _showBottomSheet(context,task);
          },
          child: TaskTile(task),
        )
      ],
    ),
  ),
  ));}
  if(task.date==DateFormat.yMd().format(_selecteddate)){
    DateTime date=DateFormat.jm().parse(task.starttime.toString());
    print(date);

  return AnimationConfiguration.staggeredList(position: index,  child: SlideAnimation(
    child: FadeInAnimation(


      child: Row(

        children: [
          GestureDetector(
            onTap: (){
              _showBottomSheet(context,task);
            },
            child: TaskTile(task),
          )
        ],
      ),
    ),
  ));}

else {
  return Container();
          }
      },);
    })



    );
  }
  _showBottomSheet(BuildContext,Task task){
return Get.bottomSheet(
    Container(
    padding: EdgeInsets.only(top: 4),
    height: task.iscompleted==1?
    MediaQuery.of(context).size.height*0.24:MediaQuery.of(context).size.height*0.32,
    color: Colors.white,
      child: Column(
        children: [
        Container(
        height: 6,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300]
        ),
      ),

    task.iscompleted==1?Container():_bottomsheetbutton(label: "Task Completed",ontap: (){
      taskcontroller.marktaskcompleted(task!.id!.toInt());
      taskcontroller.gettask();
    Get.back();

    },clr: Colors.blue,isclosed: false,context: context),


          _bottomsheetbutton(label: "Delete",ontap: () async{
            await taskcontroller.delete(task);
            taskcontroller.gettask();
            Get.back();

          },clr: Colors.red[300]!,isclosed: false,context: context),
SizedBox(height: 25,),
          _bottomsheetbutton(label: "Close",ontap: (){
            Get.back();

          },clr: Colors.white!,isclosed: true,context: context),





      ],
      ),
));
  }
  _bottomsheetbutton({String? label,Function()? ontap,Color? clr,bool? isclosed=false,BuildContext? context}){
return GestureDetector(
  onTap: ontap,
  child: Container(

    margin: EdgeInsets.symmetric( horizontal: 14,vertical: 5),
    height: 55,
    width: MediaQuery.of(context!).size.width,

    decoration: BoxDecoration(
      color: isclosed==true?Colors.white:clr!,
      border:Border.all(width: 2,
      color: isclosed==true?Colors.grey:clr!,),
      borderRadius: BorderRadius.circular(20)
    ),
child: Center(child: Text(label!,style: isclosed==true?GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color:Colors.black
  )

):GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color:Colors.white
    )

),)),
  ),);
  }
  _addtaskbar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  )
              ),),
              Text("Today",style: GoogleFonts.lato(
                  textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  )
              ),),
            ],
          ),
        ),
        MyButton(label: "+Add Task", ontap: (){Get.to(AddTaskPage());
        taskcontroller.gettask();

        }
    )
      ],
    );
  }
}
