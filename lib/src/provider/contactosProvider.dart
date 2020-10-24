import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:simoric/src/bloc/login_bloc.dart';

import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class ContactoProvider {
  final String _url = "https://simoric.firebaseio.com";
  final _prefs = new PreferenciasUsuario(); 

  final  fb = FirebaseDatabase.instance; 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  


  Future<Map<String, dynamic>> crearContacto(ContactModel contact,String uId) async {
       contact.uid = uId; 
       await fb.reference().child("contacts").push().set(contact.toJson());   
  }
 
  Future<List<ContactModel>> cargarContactos(String uId) async { 

     Map result; 
     final contactsRef = fb.reference().child("contacts"); 
     List<ContactModel> lista = new List(); 

     
    contactsRef.orderByChild("uid").equalTo(_prefs.idUser).onValue.listen((event) { 
      result = event.snapshot.value; 

      if(result.length>0){
          result.forEach((key, value) {  
            final model = ContactModel.fromDynamic(value);
            model.id = key;  
            lista.add(model);  
         });
      }
           
     }); 
  
    return lista; 

  }


  Future<int> borrarContacto( String uId,contactId ) async { 

    final url  = '$_url/usuarios/$uId/contactos/$contactId.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print( resp.body );
    return 1;
  }
}