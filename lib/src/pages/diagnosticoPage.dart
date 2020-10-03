import 'package:flutter/material.dart';

class DiagnosticoPage extends StatefulWidget {
  @override
  _DiagnosticoPageState createState() => _DiagnosticoPageState();
}

class _DiagnosticoPageState extends State<DiagnosticoPage> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 0,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Fecha"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.fecha.compareTo(b.fecha));
            });
          },
          tooltip: "To display fecha",
        ),
        DataColumn(
          label: Text("Hora"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.hora.compareTo(b.hora));
            });
          },
          tooltip: "To display hora",
        ),
        DataColumn(
          label: Text("bpm"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.bpm.compareTo(b.bpm));
            });
          },
          tooltip: "To display bpm",
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
                  Text(name.fecha),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.hora),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.bpm),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(IconButton(
                    icon: Icon(
                      Icons.open_in_browser,
                      color: Colors.blue,
                    ),
                    onPressed: null)),
              ],
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Diagnostico"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  colors: [Colors.green[400], Colors.green[600]]),
            ),
          ),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.center,
                    colors: [Colors.green[400], Colors.green[600]]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 150,
                            child: Image.asset("assets/mascota.png"),
                          ),
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Text(
                                  'Aquí puedes ver tus \ndiagnosticos realizados \nen los ultimos días',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0))),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(55.0))),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Container(
                              child: bodyData(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Name {
  String fecha;
  String hora;
  String bpm;

  Name({this.fecha, this.hora, this.bpm});
}

var names = <Name>[
  Name(fecha: "3/10/2020", hora: "16:00", bpm: "82"),
];
