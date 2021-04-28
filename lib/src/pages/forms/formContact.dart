import 'package:flutter/material.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/contactosProvider.dart';
import 'package:simoric/src/utils/utils.dart' as utils;

class FormContacto extends StatefulWidget {
  @override
  _FormContactoState createState() => _FormContactoState();
}

class _FormContactoState extends State<FormContacto> {
  final formKey = GlobalKey<FormState>();
  ContactModel contact = new ContactModel();
  ContactoProvider contactoProvider = ContactoProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Contactos"),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(begin: Alignment.center, colors: [
                    Color.fromRGBO(162, 243, 26, 1),
                    Color.fromRGBO(25, 217, 50, 1)
                  ]),
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
                          colors: [
                            Color.fromRGBO(162, 243, 26, 1),
                            Color.fromRGBO(25, 217, 50, 1)
                          ]),
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
                                key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onSaved: (value) =>
                                            contact.name = value,
                                        validator: (String value) =>
                                            (value.isEmpty)
                                                ? "Ingrese un nombre"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: "Nombre",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onSaved: (value) =>
                                            contact.lastName = value,
                                        validator: (String value) =>
                                            (value.isEmpty)
                                                ? "Ingrese un apellido"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: "Apellido",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onSaved: (value) =>
                                            contact.email = value,
                                        validator: (String value) =>
                                            (value.isEmpty)
                                                ? "Ingrese un correo"
                                                : null,
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
                                        onSaved: (value) => contact
                                            .phoneNumber = int.parse(value),
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return "El campo está vacío";
                                          } else {
                                            return (utils.isNumeric(value) &&
                                                    value.length == 10)
                                                ? null
                                                : "No es un número válido";
                                          }
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
                                        onPressed: () {
                                          if (!formKey.currentState
                                              .validate()) {
                                            return;
                                          } else {
                                            formKey.currentState.save();
                                            contactoProvider
                                                .crearContacto(
                                                    contact, _prefs.idUser)
                                                .then((value) {
                                              if (value.id != null) {
                                                utils.mostrarAlerta(
                                                    context,
                                                    "Se ha creado el contacto",
                                                    "Genial!");

                                                Navigator.of(context).pop();
                                              } else {
                                                utils.mostrarAlerta(
                                                    context,
                                                    "Ocurrio un error",
                                                    "Advertencia");
                                              }
                                            });
                                          }
                                        },
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
