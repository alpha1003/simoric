import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:simoric/routes.dart';
import 'package:simoric/src/bloc/login_bloc.dart';

import 'package:simoric/src/bloc/provider.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/pages/profilePage.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _prefs = new PreferenciasUsuario();
  await _prefs.initPrefs();
  await Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;
  LoginBloc _bloc = LoginBloc();

  _auth.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out!');
      _prefs.inicioPage = SplashScreen.routeName;
    } else {
      print('User is signed in!');
      print(_auth.currentUser);
      _prefs.idUser = _auth.currentUser.uid;
      _bloc.cargarUsuario();
      _prefs.inicioPage = HomePage.routeName;
    }
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final _prefs = new PreferenciasUsuario();

    if (_prefs.first == true) {
      _prefs.inicioPage = SplashScreen.routeName;
      _prefs.first = false;
    }
    //else {
    //  if (_prefs.idUser != "") {
    //    _prefs.inicioPage = HomePage.routeName;
    //  } else {
    //    _prefs.inicioPage = LoginPage.routeName;
    //  }
    //}

    return Provider(
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Simoric',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: kPrimaryColor,
        ),
        initialRoute: _prefs.inicioPage,
        routes: routes,
      ),
    );
  }
}
