import 'package:flutter/material.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:simoric/src/provider/contactosProvider.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';
import 'package:simoric/src/utils/utils.dart' as utils;

class FormUser extends StatefulWidget {
  @override
  _FormUserState createState() => _FormUserState();

  static final String routeName = "userForm";
}

class _FormUserState extends State<FormUser> {
  final formKey = GlobalKey<FormState>();
  UsuarioModel _usuarioModel = new UsuarioModel();
  UsuarioProvider _usuarioProvider = UsuarioProvider();
  ContactoProvider contactoProvider = ContactoProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  String _tipo = "Usuario general";
  List<DropdownMenuItem<String>> lista = [
    DropdownMenuItem(value: "Medico", child: Text("Medico")),
    DropdownMenuItem(value: "Paciente", child: Text("Paciente")),
    DropdownMenuItem(value: "Usuario general", child: Text("Usuario general")),
  ];

  @override
  Widget build(BuildContext context) {
    _usuarioModel = ModalRoute.of(context).settings.arguments;
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
                                        initialValue: _usuarioModel.name,
                                        onSaved: (value) =>
                                            _usuarioModel.name = value,
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
                                            _usuarioModel.lastname = value,
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
                                        onSaved: (value) => _usuarioModel.age =
                                            int.parse(value),
                                        validator: (String value) =>
                                            (!utils.isNumeric(value))
                                                ? "Ingrese un número válido"
                                                : null,
                                        decoration: InputDecoration(
                                          labelText: "Edad",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onSaved: (value) => _usuarioModel
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
                                    _crearTipo(),
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
                                              "Guardar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          _validar(context);
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

  void _validar(BuildContext c) async {
    if (!formKey.currentState.validate() || _usuarioModel.rol == "rol") {
      return;
    } else {
      formKey.currentState.save();
      final res = await _usuarioProvider.actualizarUsuario(_usuarioModel);
      if (res == "OK") {
        utils.mostrarAlerta(c, "Se ha actualizado la informacion", "Mensaje");
        Future.delayed(Duration(seconds: 2))
            .then((value) => Navigator.of(context).pop());
      } else {
        utils.mostrarAlerta(c, res, "Error");
      }
    }
  }

  Widget _crearTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("Tipo de usuario"),
        DropdownButton<String>(
          items: lista,
          value: _tipo,
          elevation: 2,
          icon: Icon(Icons.person_outline, color: Colors.lightGreen),
          onChanged: (String value) {
            _tipo = value;
            setState(() {
              _usuarioModel.rol = _tipo;
            });
          },
        ),
      ],
    );
  }
}
