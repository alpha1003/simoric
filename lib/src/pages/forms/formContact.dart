import 'package:flutter/material.dart';

class FormContacto extends StatefulWidget {
  @override
  _FormContactoState createState() => _FormContactoState();
}

class _FormContactoState extends State<FormContacto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Contactos"),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      colors: [Colors.green[400], Colors.green[600]]),
                ),
              ),
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height * 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          colors: [Colors.green[400], Colors.green[600]]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset("assets/mascota.png"),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Text('Llena todos \nlos campos',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45.0)),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 55.0,
                                horizontal: 15.0,
                              ),
                              child: Form(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Se debe ingresar un nombre";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Primer nombre",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Se debe ingresar el apellido";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: "Apellidos",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Se debe ingresar un correo";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText:
                                              "Correo; example@correo.com",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "Se debe ingresar un telefono";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: "Telefono",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: RaisedButton(
                                        elevation: 0.0,
                                        onPressed: () {},
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0)),
                                        padding: EdgeInsets.all(2.0),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.green[400],
                                                  Colors.green[600]
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(100.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 100.0,
                                                minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Registrar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    )),
              ),
            )));
  }
}
