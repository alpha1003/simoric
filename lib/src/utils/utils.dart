import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje, String titulo) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text("OK"))
          ],
        );
      });
}

bool mostrarAlertaPregunta(
    BuildContext context, String mensaje, String titulo) {
  bool res;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            FlatButton(
                onPressed: () {
                  res = false;
                  Navigator.of(context).pop();
                },
                child: Text("NO")),
            FlatButton(
              onPressed: () => res = true,
              child: Text("SÍ"),
            ),
          ],
        );
      });

  return res;
}

Future<bool> confirmar(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("CONFIRMAR"),
        content: const Text("Está seguro que desea borrar este item?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("DELETE")),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
        ],
      );
    },
  );
}

Future<bool> confirmar2(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("CONFIRMAR"),
        content: const Text("Está seguro que desea cerrar sesion?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("SÍ")),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCELAR"),
          ),
        ],
      );
    },
  );
}
