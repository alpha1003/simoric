import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/models/registroModel.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/utils/utils.dart' as utils;
import 'package:simoric/src/pages/widgets/headerWidget.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/registroProvider.dart';

import 'widgets/mainDrawer.dart';

class DiagnosticoPage extends StatefulWidget {
  @override
  _DiagnosticoPageState createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  List<RegistroModel> _lista;
  RegistroProvider _rp = RegistroProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();
  RegistroProvider _registroProvider = RegistroProvider();
  LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bloc.cargarRegistros();

    return SafeArea(
        child: Scaffold(
            appBar: buildAppbar(),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HeaderWidget(size: size, text: "Diagnóstico"),
                    Container(
                      //width: 400,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(200, 210, 200, 76),
                          Color.fromRGBO(255, 255, 255, 63)
                        ]),
                      ),
                      margin:
                          EdgeInsets.only(left: 10.0, top: 1.0, bottom: 15.0),
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("Médico a cargo: Carlos Montes")
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("3202262957")
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.mail),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text("alpha@correo.com")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        "Registros",
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    _crearListado(bloc),
                  ],
                ),
              ),
            ),
            drawer: Drawer(
              child: MainDrawer(),
            ),
            floatingActionButton: SpeedDial(
              backgroundColor: Colors.green,
              animatedIcon: AnimatedIcons.menu_close,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.add),
                  label: "Agregar médico",
                  onTap: () {},
                ),
                SpeedDialChild(
                  child: Icon(Icons.local_hospital_rounded),
                  backgroundColor: Colors.red[300],
                  label: "Tomar medida",
                  onTap: () =>
                      Navigator.pushNamed(context, MedicionPage.routeName),
                ),
              ],
            )));
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text("Diagnosticos"),
      elevation: 0.0,
    );
  }

  Widget _crearListado(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.lista2Stream,
      builder:
          (BuildContext context, AsyncSnapshot<List<RegistroModel>> snapshot) {
        if (snapshot.hasData) {
          final registros = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 20,
                bottom: MediaQuery.of(context).size.width / 20),
            shrinkWrap: true,
            itemCount: registros.length,
            itemBuilder: (context, i) => _crearItem(context, registros[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, RegistroModel registro) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          _registroProvider.borrarRegistro(_prefs.idUser, registro.id);
        },
        confirmDismiss: (direccion) async {
          return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Desea eliminar el item?"),
                  title: Text("Confirmacion"),
                  actions: [
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("NO")),
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text("SÍ")),
                  ],
                );
              });
        },
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Fecha: ${registro.fecha}"),
                subtitle: Text("BPM: ${registro.bpm} \n"
                    "Frecuencia: ${registro.alerta}"),
                //onTap: () => Navigator.pushNamed(context, ProductoPage.routeName, arguments: producto ),
              ),
            ],
          ),
        ));
  }
}
