import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:simoric/src/bloc/validators.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/contactosProvider.dart';

class LoginBloc with Validators {


  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _listController   = BehaviorSubject<List<ContactModel>>();
  ContactoProvider _contactoProvider = ContactoProvider(); 
  final _prefs = PreferenciasUsuario(); 

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
  Stream<List<ContactModel>> get listaStream => _listController.stream; 

  Stream<bool> get formValidStream => 
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true );



  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  // Insertar valores al Stream
  Function(List<ContactModel>) get addList  => _listController.sink.add;
 
  List<ContactModel> get list    => _listController.value;
 

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _listController?.close(); 
  } 

   void cargarContactos() async { 
     print(_listController.value); 
     if(_listController.value==null){
     final contactos = await _contactoProvider.cargarContactos(_prefs.idUser);
      _listController.sink.add(contactos);   
   }
 }
}