import 'package:flutter/material.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/pages/forms/formContact.dart';

import 'mainDrawer.dart';

class ContactoPage extends StatefulWidget {
  static final String routeName = "contactoPage";
  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage> {
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

  AppBar buildAppbar() {
    return AppBar(
      title: const Text("Contactos"),
      elevation: 0.0,
      centerTitle: true,
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
                label: Text("Nombre"),
                tooltip: "To display first name of the Name",
              ),
              DataColumn(
                label: Text("Celular"),
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
                          width: 100,
                          child: Text(name.firstName),
                        ),
                      ),
                      DataCell(
                        Container(
                          width: 100,
                          child: Text(name.telephone.toString()),
                        ),
                      ),
                      DataCell(
                        Container(
                            width: 100,
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
          Header(size: size),
          Tabla(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: size.height / 6,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            height: size.height,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Image.asset("assets/mascota.png"),
                  ),
                  Text(
                    'Agrega o modifica un \ncontacto al que desees \nnotificar en caso de alerta.',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
