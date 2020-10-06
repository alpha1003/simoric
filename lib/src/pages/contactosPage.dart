import 'package:flutter/material.dart';
import 'package:simoric/src/pages/forms/formContact.dart';

class ContactoPage extends StatefulWidget {
  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 0,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Nombre"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
          tooltip: "To display first name of the Name",
        ),
        DataColumn(
          label: Text("Celular"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.telephone = b.telephone);
            });
          },
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
                  Text(name.firstName),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(name.telephone.toString()),
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
            title: const Text("Contactos"),
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
                                    'Agrega o modifica \nun contacto al que \ndesees notificar en \ncaso de alerta.',
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
          floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => FormContacto()));
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blueAccent)),
    );
  }
}

class Name {
  String firstName;
  String lastName;
  int telephone;

  Name({this.firstName, this.lastName, this.telephone});
}

var names = <Name>[
  Name(firstName: "Jose", lastName: "Camargo", telephone: 3215149242),
  Name(firstName: "Martin", lastName: "Burgos", telephone: 3215149242),
  Name(firstName: "Rohan", lastName: "Singh", telephone: 3215149242),
];
