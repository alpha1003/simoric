import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  final String _url = "https://simoric.firebaseio.com";
  final _prefs = new PreferenciasUsuario(); 
  String _firebaseToken = "AIzaSyBvCvY_hynm-0r_5s_tm8nrWb9xmgkeg9k";
  
  final  fb = FirebaseDatabase.instance; 
  final FirebaseAuth _auth = FirebaseAuth.instance; 
 

  //mDatabase = FirebaseDatabase.getInstance().getReference();

  
  Future<Map<String,dynamic>> nuevoUsuario(String mail, String passwd) async {

      final authData = {
        "email" : mail,
        "password" : passwd,
        "returnSecureToken" : true,
      };

      final resp = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken",
          body: json.encode(authData)
      );

      Map<String,dynamic> decodedData = json.decode(resp.body); 
    
      print(decodedData);

      if(decodedData.containsKey("idToken")){
        _prefs.token = decodedData["idToken"]; 
        return {"ok" : true, "token" : decodedData["idToken"] };
      }else{
          return {"ok" : false, "mensaje" : decodedData["error"]["message"] };
      }
    }

 Future<UserCredential> nuevoUsuario2(String mail, String passwd, UsuarioModel user) async {
      final res = await _auth.createUserWithEmailAndPassword(email: mail, password: passwd);
      print(res); 
      fb.reference().child("users").child(res.user.uid).set(user.toJson());
      return res; 
  }

  Future<UserCredential> login2(String mail, String passwd) async {

      final res =  await _auth.signInWithEmailAndPassword(email: mail, password: passwd); 
      print(res); 
      _prefs.idUser = res.user.uid; 
      return res; 
  }

  Future login(String mail, String passwd) async {
    final authData = {
      "email": mail,
      "password": passwd,
      "returnSecureToken": true,
    };

    final resp = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken",
        body: json.encode(authData));

    Map<String, dynamic> decodedData = json.decode(resp.body);

    print(decodedData);

    if (decodedData.containsKey("idToken")) {
      _prefs.token = decodedData["idToken"];
      return {"ok": true, "token": decodedData["idToken"]};
    } else {
      return {"ok": false, "mensaje": decodedData["error"]["message"]};
    }
  }

  Future<Map<String, dynamic>> crearUsuarioDB( UsuarioModel usuario ) async {
 
    final url = '$_url/usuarios.json?auth=${_prefs.token}';
    final resp = await http.post( url, body: usuarioModelToJson(usuario) );
    final decodedData = json.decode(resp.body);
    
    //
    
    _prefs.idUser = decodedData["name"];  
    print(_prefs.idUser);
    return decodedData;

  }

 

  
  



}
