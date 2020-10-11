import 'package:flutter/material.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/diagnosticoPage.dart';
import 'package:simoric/src/pages/inicioPage.dart';
import 'package:simoric/src/pages/medicionPage.dart';


class HomePage extends StatefulWidget {
  static final String routeName = "homePage"; 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectPage(_currentIndex),
      bottomNavigationBar: navigationBar(),
    );
  }

  Widget _selectPage(int val) {
    switch (val) {
      case 0:
        return InicioPage();
      case 1:
        return DiagnosticoPage();
      case 2:
        return ContactoPage();
    }
  }

  Widget navigationBar() {
    return BottomNavigationBar(
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Inicio")),
        BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint), title: Text("Medicion")),
        BottomNavigationBarItem(
            icon: Icon(Icons.history), title: Text("Historial")),
      ],
      currentIndex: _currentIndex,
    );
  }
}
