import 'package:flutter/material.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/pages/forms/formContact.dart';
import 'package:simoric/src/pages/widgets/headerWidget.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/contactosProvider.dart';

import 'widgets/mainDrawer.dart';

class ContactoPage extends StatefulWidget {
  static final String routeName = "contactoPage";

  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  Size size;
  LoginBloc bloc = LoginBloc();
  ContactoProvider _contactoProvider = ContactoProvider();
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  @override
  void initState() {
    bloc.cargarContactos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size * 1.5;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text("Contactos"),
            ),
            body: _body(bloc),
            drawer: Drawer(
              child: MainDrawer(),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, FormContacto.routeName);
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.blueAccent)));
  }

  Widget _body(LoginBloc bloc) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWidget(
            size: size,
            text: "Gestiona aquí tus \n Contactos \n",
          ),
          _crearListado(bloc),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _crearListado(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.listaStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ContactModel>> snapshot) {
        if (snapshot.hasData) {
          final contactos = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 20,
                bottom: MediaQuery.of(context).size.width / 20),
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: contactos.length,
            itemBuilder: (context, i) => _crearItem(context, contactos[i]),
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 100.0,
              ),
              Center(child: CircularProgressIndicator()),
              Text("Cargando...")
            ],
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ContactModel contact) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) {
          _contactoProvider.borrarContacto(_prefs.idUser, contact.id);
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
                title: Text('${contact.name} - ${contact.lastName}'),
                subtitle: Text("Celular: ${contact.phoneNumber} \n"
                    "Email: ${contact.email}"),
                //onTap: () => Navigator.pushNamed(context, ProductoPage.routeName, arguments: producto ),
              ),
            ],
          ),
        ));
  }
}
