import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Size size = MediaQuery.of(context).size * 1.5;

    bloc.cargarRegistros();

    return SafeArea(
      child: Scaffold(
          appBar: buildAppbar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderWidget(size: size, text: "Diagnóstico"),
                _crearListado(bloc),
              ],
            ),
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MedicionPage.routeName),
              child: Icon(Icons.local_hospital),
              backgroundColor: Colors.blueAccent)),
    );
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
