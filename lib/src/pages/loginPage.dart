import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    colors: [Colors.green[500], Colors.green[700]]),
                boxShadow: [BoxShadow(blurRadius: 0.0)],
                borderRadius: BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 40.0))),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 2,
              child: Padding(
                padding: EdgeInsets.all(36.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.contain,
                        scale: 0.25,
                      ),
                    ),
                    Text("Sistema de monitoreo de ritmo cardiaco"),
                    SizedBox(
                      height: 38.0,
                    ),
                    mailTF(),
                    SizedBox(
                      height: 15.0,
                    ),
                    passwordTF(),
                    SizedBox(
                      height: 25.0,
                    ),
                    loginButton(),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("¿Usuario nuevo?"),
                        RaisedButton(
                          child: Text("Registrarse"),
                          shape: StadiumBorder(),
                          elevation: 1.0,
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      child: Text(
                        "Continuar como invitado",
                      ),
                      elevation: 1.0,
                      color: Colors.orangeAccent,
                      shape: StadiumBorder(),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget mailTF() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget passwordTF() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Contraseña",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      elevation: 5.0,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green[400], Colors.green[600]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            "Iniciar sesión",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
