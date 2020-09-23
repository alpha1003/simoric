import 'package:flutter/material.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/pages/loginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: _selectPage(_currentIndex),
        bottomNavigationBar: navigationBar(),
    );
  }

  Widget _selectPage(int val){
        switch(val){
            case 0: return LoginPage(); 
            case 1: return MedicionPage();     
        }
  }

  Widget navigationBar(){
      return BottomNavigationBar(
          onTap: (i){
              setState(() {
                  _currentIndex = i; 
              });
          },
          items: [
             BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Inicio")),
             BottomNavigationBarItem(icon: Icon(Icons.fingerprint), title: Text("Medicion")),
             BottomNavigationBarItem(icon: Icon(Icons.history), title: Text("Historial")),
          ],
          currentIndex: _currentIndex,
      );
  }

}