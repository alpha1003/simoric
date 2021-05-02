import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/bloc/provider.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';

import 'package:simoric/src/utils/utils.dart' as utils;

class RegistroPage extends StatefulWidget {
  static final String routeName = "RegistroPage";

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  auth.User currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.pushNamed(context, HomePage.routeName);
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    auth.User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      // Check is already sign up
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // Update data to server if new user
        FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .set({
          'name': firebaseUser.displayName,
          'lastname': "lastname",
          'email': firebaseUser.email,
          'age': 1,
          'phoneNumber': 1,
          'photoUrl': firebaseUser.photoURL,
          'id': firebaseUser.uid,
          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          'chattingWith': null
        });

        _prefs.nombre = firebaseUser.displayName;
        _prefs.idUser = firebaseUser.uid;

        // Write data to local
        currentUser = firebaseUser;
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('nickname', currentUser.displayName);
        await prefs.setString('photoUrl', currentUser.photoURL);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0].data()['id']);
        await prefs.setString('nickname', documents[0].data()['nickname']);
        await prefs.setString('photoUrl', documents[0].data()['photoUrl']);
        await prefs.setString('aboutMe', documents[0].data()['aboutMe']);
      }
      Fluttertoast.showToast(msg: "Sign in success");
      this.setState(() {
        isLoading = false;
      });

      Navigator.pushNamed(context, HomePage.routeName);
    } else {
      Fluttertoast.showToast(msg: "Sign in fail");
      this.setState(() {
        isLoading = false;
      });
    }
  }

////////////////////////////////////////////////////////////////////////////
  final usuarioProvider = new UsuarioProvider();
  final formkey = GlobalKey<FormState>();
  UsuarioModel user = UsuarioModel();
  final _prefs = PreferenciasUsuario();
  String _value = "Usuario general";

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
              height: 180.0,
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
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  Text("Crear cuenta", style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 60.0),
                  _crearTipo(),
                  SizedBox(height: 30.0),
                  _crearEmail(bloc),
                  SizedBox(height: 30.0),
                  _crearPassword(bloc),
                  SizedBox(height: 30.0),
                  _crearNombre(),
                  SizedBox(height: 30.0),
                  _crearApellido(),
                  SizedBox(height: 30.0),
                  _crearEdad(),
                  SizedBox(height: 30.0),
                  _crearPhone(),
                  SizedBox(height: 30.0),
                  _crearBoton(bloc, context)
                ],
              ),
            ),
          ),
          TextButton(
            child: Text("¿Ya tienes cuenta? Login"),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginPage.routeName),
          ),
          FlatButton(
              onPressed: () => handleSignIn().catchError((err) {
                    Fluttertoast.showToast(msg: "Sign in fail");
                    this.setState(() {
                      isLoading = false;
                    });
                  }),
              child: Text(
                'SIGN IN WITH GOOGLE',
                style: TextStyle(fontSize: 16.0),
              ),
              color: Color(0xffdd4b39),
              highlightColor: Color(0xffff7f7f),
              splashColor: Colors.transparent,
              textColor: Colors.white,
              padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0)),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearTipo() {
    List<DropdownMenuItem<String>> lista = [
      DropdownMenuItem(value: "Medico", child: Text("Medico")),
      DropdownMenuItem(value: "Paciente", child: Text("Paciente")),
      DropdownMenuItem(
          value: "Usuario general", child: Text("Usuario general")),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Tipo de usuario"),
        DropdownButton<String>(
          items: lista,
          value: _value,
          elevation: 2,
          icon: Icon(Icons.person_outline, color: Colors.lightGreen),
          onChanged: (String value) {
            _value = value;
            setState(() {
              print(_value);
            });
          },
        ),
      ],
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(Icons.alternate_email, color: Colors.lightGreen),
                hintText: 'ejemplo@correo.com',
                labelText: 'Correo electrónico',
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
            onSaved: (val) => user.email = val,
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
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outline, color: Colors.lightGreen),
                labelText: 'Contraseña',
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearNombre() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.perm_contact_calendar, color: Colors.lightGreen),
          hintText: 'Tu nombre',
          labelText: 'Nombre',
        ),
        onSaved: (val) => user.name = val,
      ),
    );
  }

  Widget _crearApellido() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.perm_contact_calendar, color: Colors.lightGreen),
          hintText: 'Tu apellido',
          labelText: 'Apellido',
        ),
        onSaved: (val) => user.lastname = val,
      ),
    );
  }

  Widget _crearEdad() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.perm_contact_calendar, color: Colors.lightGreen),
          hintText: 'Tu edad',
          labelText: 'Edad',
        ),
        validator: (value) {
          return (utils.isNumeric(value)) ? null : "No es válido";
        },
        onSaved: (val) => user.age = int.parse(val),
      ),
    );
  }

  Widget _crearPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: Colors.lightGreen),
          hintText: 'Número de celular',
          labelText: 'Número de celular',
        ),
        validator: (value) {
          return (utils.isNumeric(value) || value.length != 10)
              ? null
              : "No es un valor numérico";
        },
        onSaved: (val) => user.phoneNumber = int.parse(val),
      ),
    );
  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ElevatedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
              child: Text('Registrar'),
            ),
            style: ButtonStyle(),
            onPressed:
                snapshot.hasData ? () => _registro(context, bloc) : null);
      },
    );
  }

  _registro(BuildContext context, LoginBloc bloc) async {
    if (!formkey.currentState.validate()) {
      return;
    } else {
      formkey.currentState.save();

      var res =
          await usuarioProvider.nuevoUsuario2(bloc.email, bloc.password, user);

      if (res == "OK") {
        utils.mostrarAlerta(
            context, "El usuario ha sido creado con éxito", "Bien hecho");
        Navigator.pushNamed(context, HomePage.routeName);
      } else {
        utils.mostrarAlerta(context, res.toString(), "Hubo un error");
      }
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
}
