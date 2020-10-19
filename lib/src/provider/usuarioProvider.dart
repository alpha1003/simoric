import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {
  String _firebaseToken = "AIzaSyAQpBiX-NdJIKzAg2wci6O3yFEcZ9Kpkw8";
  final _prefs = new PreferenciasUsuario();
  
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
  

  Future<Map<String, dynamic>> login(String mail, String passwd) async {
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
}
