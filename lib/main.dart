import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simoric/src/pages/medicionPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simoric',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.orange,
      ),
      initialRoute: "login",
      routes: <String, WidgetBuilder>{
        "login" : (BuildContext context) => MedicionPage(),  
      },
    );
  }
}
