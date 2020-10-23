import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key); 


  @override
  Widget build(BuildContext context) { 
    final _prefs = PreferenciasUsuario();

    final _auth = FirebaseAuth.instance; 

    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Text(
                _prefs.nombre,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                _prefs.userMail,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      //Now let's Add the button for the Menu
      //and let's copy that and modify it
      ListTile(
        onTap: () {},
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("Perfil"),
      ),

      Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: ListTile(
          onTap: () {},
          leading: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text(
            "Configuración",
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ListTile(
        onTap: () async {
            final res = await _auth.signOut(); 
        },
        leading: Icon(
          Icons.exit_to_app,
          color: Colors.black,
        ),
        title: Text("Cerrar sesión"),
      ),
    ]);
  }
}
