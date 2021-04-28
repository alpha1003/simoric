import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simoric/src/models/registroModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class RegistroProvider {
  final firestoreInstance = FirebaseFirestore.instance;
  PreferenciasUsuario _prefs = PreferenciasUsuario();

  Future agregarRegistro(String uid, RegistroModel reg) async {
    var res = await firestoreInstance
        .collection("users")
        .doc(uid)
        .collection("registros")
        .add(reg.toJson());

    return res;
  }

  Future<List<RegistroModel>> buscarRegistros(String uid) async {
    List<RegistroModel> lista = new List();
    RegistroModel reg = RegistroModel();

    await firestoreInstance
        .collection("users")
        .doc(_prefs.idUser)
        .collection("registros")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        //print("ELEMENTO: " + element.data().toString());
        reg = RegistroModel.fromDynamic(element.data());
        reg.id = element.id;
        //print("REGISTRO: " + reg.toString());
        lista.add(reg);
      });
    });

    print(lista);

    return lista;
  }

  Future borrarRegistro(String uid, String rid) async {
    await firestoreInstance
        .collection("users")
        .doc(uid)
        .collection("registros")
        .doc(rid)
        .delete();
  }
}
