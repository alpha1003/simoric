import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }

  get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _prefs.setString('nombre', value);
  }

  get idUser {
    return _prefs.getString('idUser') ?? '';
  }

  set idUser(String value) {
    _prefs.setString('idUser', value);
  }

  get userMail {
    return _prefs.getString('userMail') ?? '';
  }

  set userMail(String value) {
    _prefs.setString('userMail', value);
  }

  get inicioPage {
    return _prefs.getString('inicioPage') ?? '';
  }

  set inicioPage(String value) {
    _prefs.setString('inicioPage', value);
  }

  get first {
    return _prefs.getBool('first') ?? true;
  }

  set first(bool value) {
    _prefs.setBool('first', value);
  }

  get picUrl {
    return _prefs.getString('picUrl') ?? "";
  }

  set picUrl(String value) {
    _prefs.setString('picUrl', value);
  }

  get userRol {
    return _prefs.getString('userRol') ?? "";
  }

  set userRol(String value) {
    _prefs.setString('userRol', value);
  }
}
