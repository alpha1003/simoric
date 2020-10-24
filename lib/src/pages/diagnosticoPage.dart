import 'package:flutter/material.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/pages/contactosPage.dart';
import 'package:simoric/src/pages/medicionPage.dart';
import 'package:simoric/src/pages/widgets/headerWidget.dart';

import 'widgets/mainDrawer.dart';

class DiagnosticoPage extends StatefulWidget {
  @override
  _DiagnosticoPageState createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: buildAppbar(),
          body: Body(),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () =>
                  Navigator.pushNamed(context, MedicionPage.routeName),
              child: Icon(Icons.local_hospital),
              backgroundColor: Colors.blueAccent)
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text("Diagnosticos"),
      elevation: 0.0,
    );
  }
}

class Tabla extends StatelessWidget {
  const Tabla({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: DataTable(
            onSelectAll: (b) {},
            sortColumnIndex: 0,
            sortAscending: true,
            columns: <DataColumn>[
              DataColumn(
                label: Text("Fecha"),
                tooltip: "To display first name of the Name",
              ),
              DataColumn(
                label: Text("Frecuencia"),
                numeric: false,
                tooltip: "To display number cell",
              ),
              DataColumn(
                label: Text("Bpm"),
                numeric: false,
                tooltip: "To display number cell",
              ),
              DataColumn(
                label: Text("Detalles"),
                tooltip: "To display delete",
              ),
            ],
            rows: names
                .map(
                  (name) => DataRow(
                    cells: [
                      DataCell(
                        Container(
                          width: 80,
                          child: Text(name.fecha),
                        ),
                      ),
                      DataCell(
                        Container(width: 50, child: Text(name.frecuencia)),
                      ),
                      DataCell(
                        Container(width: 50, child: Text(name.bpm)),
                      ),
                      DataCell(
                        Container(
                            width: 50,
                            child: IconButton(
                                icon: Icon(
                                  Icons.open_in_browser,
                                  color: Colors.blue,
                                ),
                                onPressed: null)),
                      ),
                    ],
                  ),
                )
                .toList()));
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size * 1.5;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         HeaderWidget(size: size, text: "Diagnóstico"),
          Tabla(),
        ],
      ),
    );
  }
}

class Name {
  String fecha;
  String frecuencia;
  String bpm;

  Name({this.fecha, this.frecuencia, this.bpm});
}

var names = <Name>[
  Name(fecha: "3/10/2020", frecuencia: "Normal", bpm: "82"),
];
