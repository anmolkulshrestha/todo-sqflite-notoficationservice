import 'package:get/get.dart';
import 'package:untitled21/db/db_helper.dart';

import '../models/task.dart';
class TaskController extends GetxController{
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  var tasklist= <Task>[].obs;
Future<int> addtask({Task? task}) async {
    return await  DBhelper.insert(task);

}

  Future<void> gettask() async{
    List<Map<String,dynamic>> tasks=await DBhelper.query();
    tasklist.assignAll(tasks.map((data)=> Task.fromjson(data)).toList());

  }
  Future<void> delete(Task? task) async{
var val=await DBhelper.delete(task);
  }
  Future<void> marktaskcompleted(int id)async{
  await DBhelper.update(id);
  }
}