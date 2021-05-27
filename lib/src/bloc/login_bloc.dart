import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:simoric/src/bloc/validators.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/models/registroModel.dart';
import 'package:simoric/src/models/usuarioModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/contactosProvider.dart';
import 'package:simoric/src/provider/registroProvider.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _listController = BehaviorSubject<List<ContactModel>>();
  final _listController2 = BehaviorSubject<List<RegistroModel>>();

  final _userController = BehaviorSubject<UsuarioModel>();

  ContactoProvider _contactoProvider = ContactoProvider();
  RegistroProvider _registroProvider = RegistroProvider();
  UsuarioProvider _usuarioProvider = UsuarioProvider();
  final _prefs = PreferenciasUsuario();

  // Recuperar los datos del Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<List<ContactModel>> get listaStream => _listController.stream;
  Stream<List<RegistroModel>> get lista2Stream => _listController2.stream;
  Stream<UsuarioModel> get usuarioMod => _userController.stream;

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(UsuarioModel) get changeUser => _userController.sink.add;

  // Obtener el último valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  UsuarioModel get user => _userController.value;

  // Insertar valores al Stream
  Function(List<ContactModel>) get addList => _listController.sink.add;
  List<ContactModel> get list => _listController.value;
  Function(List<RegistroModel>) get addList2 => _listController2.sink.add;
  List<RegistroModel> get list2 => _listController2.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _listController?.close();
    _listController2?.close();
    _userController?.close();
  }

  void cargarContactos() async {
    print(_listController.value);
    if (_listController.value == null) {
      final contactos = await _contactoProvider.cargarContactos(_prefs.idUser);
      _listController.sink.add(contactos);
    }
  }

  void cargarRegistros() async {
    if (_listController2.value == null) {
      final registros = await _registroProvider.buscarRegistros(_prefs.idUser);
      _listController2.sink.add(registros);
    }
  }

  void cargarUsuario() async {
    if (_userController.value == null) {
      final user = await _usuarioProvider.buscarUsuario(_prefs.idUser);
      _userController.sink.add(user);
      _prefs.userRol = user.rol;
    }
  }
}
