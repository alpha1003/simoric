import 'package:flutter/material.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';

class ProfilePage extends StatelessWidget {
  static final String routeName = "profilePage";

  @override
  Widget build(BuildContext context) {
    final UsuarioModel user = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          centerTitle: true,
          title: Text("Perfil de usuario"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _perfil(context),
              _informacion(context, user),
            ],
          ),
        ),
      ),
    );
  }

  Widget _perfil(BuildContext context) {
    double ancho = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 300.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: <Color>[
              Color.fromRGBO(162, 243, 26, 1),
              Color.fromRGBO(25, 217, 50, 1)
            ]),
            shape: BoxShape.rectangle,
          ),
        ),
        Container(
          width: 100.0,
          height: 100.0,
          margin: EdgeInsets.symmetric(horizontal: 170.0, vertical: 80.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
          child: Image(
            image: AssetImage("assets/profile-picture.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }

  _informacion(BuildContext context, UsuarioModel user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 10.0,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('NOMBRE', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(user.name),
                SizedBox(height: 10.0),
                Text('APELLIDO', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(user.lastname),
                SizedBox(height: 10.0),
                Text('EDAD', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(user.age.toString()),
                SizedBox(height: 10.0),
                Text('EMAIL', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(user.email),
                SizedBox(height: 10.0),
                Text('TELEFONO', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                Text(user.phoneNumber.toString()),
              ],
            ),
          ),
          FlatButton(
              child: Text("Editar Informacion"),
              color: Colors.greenAccent.shade200,
              onPressed: () {}),
        ],
      ),
    );
  }
}
