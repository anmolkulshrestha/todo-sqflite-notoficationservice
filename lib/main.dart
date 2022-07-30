import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled21/db/db_helper.dart';
import 'package:untitled21/home.dart';
import 'package:untitled21/theme.dart';
import 'package:untitled21/themeservices.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.light,
      themeMode: ThemeService().theme,

      home: Home(),
    );
  }
}

