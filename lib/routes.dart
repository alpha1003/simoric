import 'package:flutter/widgets.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/pages/registroPage.dart';
import 'package:simoric/src/screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (BuildContext context) => LoginPage(),
  SplashScreen.routeName: (BuildContext context) => SplashScreen(),
  RegistroPage.routeName: (BuildContext context) => RegistroPage(),
  HomePage.routeName: (BuildContext context) => HomePage(),
  MedicionPage.routeName: (BuildContext context) => MedicionPage(),
  ContactoPage.routeName: (BuildContext context) => ContactoPage(),
};
