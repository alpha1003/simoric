import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:simoric/src/bloc/login_bloc.dart';

import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class ContactoProvider {
  final firestoreInstance = FirebaseFirestore.instance;

  final String _url = "https://simoric.firebaseio.com";
  final _prefs = new PreferenciasUsuario();

  final fb = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<DocumentReference> crearContacto(
      ContactModel contact, String uId) async {
    var res = await firestoreInstance
        .collection("users")
        .doc(uId)
        .collection("contactos")
        .add(contact.toJson());
    return res;
  }

  Future<List<ContactModel>> cargarContactos(String uId) async {
    List<ContactModel> lista = List();

    await firestoreInstance
        .collection("users")
        .doc(_prefs.idUser)
        .collection("contactos")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        ContactModel cont = ContactModel.fromJson(element.data());
        cont.id = element.id;
        lista.add(cont);
      });
    });

    return lista;
  }

  Future<int> borrarContacto(String uId, contactId) async {
    firestoreInstance
        .collection("users")
        .doc(_prefs.idUser)
        .collection("contactos")
        .doc(contactId)
        .delete();

    return 1;
  }
}
