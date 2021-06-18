import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'widgets/mainDrawer.dart';

class MedicoPage extends StatelessWidget {
  static final routeName = "medicoPage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Control de pacientes'),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.person),
                  text: "Pacientes",
                ),
                Tab(
                  icon: Icon(Icons.person_add_alt_1),
                  text: "Solicitudes",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[_crearItem(context), _crearItem2()],
          ),
          drawer: Drawer(
            child: MainDrawer(),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.person_add_rounded),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget _crearItem(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(28, 84, 5, 100),
                  Color.fromRGBO(46, 255, 136, 100)
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            child: FlatButton(
              child: Row(
                children: [
                  Container(
                    width: 75.0,
                    height: 75.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage("assets/profile.jpg"),
                        fit: BoxFit.cover,
                        //fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Martin Burgos",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Ultima medida: 85bpm",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Ultimo seguimiento: 23-5-21",
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          size: 35.0,
                        ),
                        onPressed: () => _mostrarInformacion(context),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.message_rounded,
                          size: 35.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _crearItem2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(28, 84, 5, 100),
                  Color.fromRGBO(46, 255, 136, 100)
                ],
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            padding: EdgeInsets.all(20.0),
            child: FlatButton(
              child: Row(
                children: [
                  Container(
                    width: 75.0,
                    height: 75.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage("assets/profile-picture.jpg"),
                        fit: BoxFit.cover,
                        //fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ana Mesa",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Mail: alpha@correo.com",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.check,
                          size: 35.0,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever_outlined,
                          size: 35.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Future _mostrarInformacion(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 400.0,
                  height: 300.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Martín Burgos"),
                      SizedBox(
                        height: 10.0,
                      ),
                      _crearTabla(),
                    ],
                  ),
                ),
              ),
              actions: [
                FlatButton(
                  child: Text("Aceptar"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _crearTabla() {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'Fecha',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'BPM',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Estado',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        DataColumn(
          label: Text(
            'Alerta',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('23-5-21')),
            DataCell(Text('85')),
            DataCell(Text('Reposo')),
            DataCell(Text('Normal')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('21-5-21')),
            DataCell(Text('95')),
            DataCell(Text('Reposo')),
            DataCell(Text('Normal')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('19-5-21')),
            DataCell(Text('84')),
            DataCell(Text('Reposo')),
            DataCell(Text('Normal')),
          ],
        ),
      ],
    );
  }
}
