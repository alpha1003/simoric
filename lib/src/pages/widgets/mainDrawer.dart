import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simoric/src/pages/profilePage.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/utils/utils.dart' as utils;

class MainDrawer extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final _prefs = PreferenciasUsuario();
    LoginBloc bloc = LoginBloc();

    bloc.cargarUsuario();

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
        onTap: () => Navigator.pushNamed(context, ProfilePage.routeName,
            arguments: bloc.user),
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
          var res = await utils.confirmar2(context);
          if (res == true) {
            await FirebaseAuth.instance.signOut();
            await googleSignIn.disconnect();
            await googleSignIn.signOut();
            _prefs.idUser = "";

            Navigator.of(context)
                .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
            //await _auth.signOut().then((value) {
            //  utils.mostrarAlerta(
            //      context, "Se ha cerrado la sesion", "INFORMACION");
            //  Future.delayed(Duration(seconds: 2));
            //  Navigator.pushReplacementNamed(context, LoginPage.routeName);
            //});
          }
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
