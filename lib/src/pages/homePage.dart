import 'package:flutter/material.dart';
import 'package:simoric/src/pages/medicionPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {
     

    return Scaffold(
        body: MedicionPage(),
        bottomNavigationBar: navigationBar(),
    );
  }

  Widget navigationBar(){
      return BottomNavigationBar(
          items: [
             BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Inicio")),
             BottomNavigationBarItem(icon: Icon(Icons.fingerprint), title: Text("Medicion")),
             BottomNavigationBarItem(icon: Icon(Icons.history), title: Text("Historial")),
          ],
          currentIndex: _currentIndex,
      );
  }
}