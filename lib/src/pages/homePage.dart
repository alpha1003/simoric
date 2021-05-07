import 'package:flutter/material.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/diagnosticoPage.dart';
import 'package:simoric/src/pages/inicioPage.dart';
import 'package:simoric/src/pages/recomendacionesPage.dart';
import 'package:simoric/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  static final String routeName = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioModel user = UsuarioModel();
  LoginBloc bloc = LoginBloc();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.cargarUsuario();
    user = bloc.user;
    if (user != null) user = ModalRoute.of(context).settings.arguments;

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
      case 3:
        return RecomendacionesPage();
    }
  }

  Widget navigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightGreen,
      unselectedItemColor: Colors.black38,
      selectedFontSize: 25.0,
      unselectedFontSize: 15.0,
      iconSize: 25.0,
      onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint), label: "Medicion"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "Contactos"),
        BottomNavigationBarItem(icon: Icon(Icons.healing), label: "Cuidados"),
      ],
      currentIndex: _currentIndex,
    );
  }
}
