import 'package:flutter/widgets.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/conversation.dart';
import 'package:simoric/src/pages/forms/formUser.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/pages/profilePage.dart';
import 'package:simoric/src/pages/forms/formContact.dart';
import 'package:simoric/src/pages/recomendacionesPage.dart';
import 'package:simoric/src/pages/registroPage.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/screens/splash/splash_screen.dart';

final _prefs = PreferenciasUsuario();

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (BuildContext context) => LoginPage(),
  SplashScreen.routeName: (BuildContext context) => SplashScreen(),
  RegistroPage.routeName: (BuildContext context) => RegistroPage(),
  HomePage.routeName: (BuildContext context) => HomePage(),
  MedicionPage.routeName: (BuildContext context) => MedicionPage(),
  ContactoPage.routeName: (BuildContext context) => ContactoPage(),
  RecomendacionesPage.routeName: (BuildContext context) =>
      RecomendacionesPage(),
  ProfilePage.routeName: (BuildContext context) => ProfilePage(),
  FormContacto.routeName: (BuildContext context) => FormContacto(),
  FormUser.routeName: (BuildContext context) => FormUser(),
  ConversationPage.routeName: (BuildContext context) =>
      ConversationPage(currentUserId: _prefs.idUser)
};
