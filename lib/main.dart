import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_using_hive/models/usermodel.dart';
import 'package:login_using_hive/screens/login.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(usermodelAdapter());
  await Hive.openBox<usermodel>("user");
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: login(),
    theme: ThemeData(scaffoldBackgroundColor: Colors.deepPurple.shade400),
  ));
}
