import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/registroPage.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/utils/utils.dart' as utils;
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/bloc/provider.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';

class LoginPage extends StatelessWidget {
  static final String routeName = "LoginPage";
  final UsuarioProvider usuarioProvider = new UsuarioProvider();
  final _prefs = PreferenciasUsuario();
  UsuarioModel _modelUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 190.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
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
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc)
              ],
            ),
          ),
          FlatButton(
            child: Text("Crear una nueva cuenta"),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, RegistroPage.routeName),
          ),
          FlatButton(
              child: Text("Entrar como invitado"),
              onPressed: () =>
                  _googleLogin() //Navigator.pushReplacementNamed(context, HomePage.routeName),
              ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.lightGreen),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.lightGreen),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Ingresar'),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 0.0,
            color: Colors.lightGreen,
            textColor: Colors.white,
            onPressed: snapshot.hasData ? () => _login2(bloc, context) : null);
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if (info != null) {
      //_prefs.nombre =
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      utils.mostrarAlerta(context, info["mensaje"], "Hubo un error");
    }
  }

  _login2(LoginBloc bloc, BuildContext context) async {
    final info = await usuarioProvider.login2(bloc.email, bloc.password);

    if (info == auth.UserCredential) {
      _prefs.idUser = info.user.uid;
      _modelUser = await usuarioProvider.buscarUsuario(_prefs.idUser);
      bloc.cargarUsuario();
      _prefs.nombre = _modelUser.name;
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } else {
      utils.mostrarAlerta(context, info, "Hubo un error");
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(162, 243, 26, 1),
        Color.fromRGBO(25, 217, 50, 1)
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.15)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 70.0, left: 30.0, child: circulo),
        Positioned(top: -30.0, right: -20.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage("assets/logo.png"),
                width: 350.0,
                height: 150.0,
              ),
              //Icon( Icons, color: Colors.white, size: 100.0 ),
              SizedBox(height: 10.0, width: double.infinity),
            ],
          ),
        )
      ],
    );
  }

  Future<auth.User> _googleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final _auth = auth.FirebaseAuth.instance;

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final auth.GoogleAuthCredential credential =
        auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final firebaseUser = (await _auth.signInWithCredential(credential)).user;

    return firebaseUser;
  }
}
