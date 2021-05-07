import 'dart:async';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/provider/mensajesProvider.dart';
import 'package:simoric/src/models/registroModel.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:simoric/src/provider/registroProvider.dart';
import 'package:simoric/src/models/contactModel.dart';
import 'package:simoric/src/provider/contactosProvider.dart';
import 'package:wakelock/wakelock.dart';
import 'package:simoric/src/utils/utils.dart' as utils;
import '../../chart.dart';

class MedicionPage extends StatefulWidget {
  static final routeName = "medicionPage";
  @override
  MedicionPageView createState() {
    return MedicionPageView();
  }
}

class MedicionPageView extends State<MedicionPage>
    with SingleTickerProviderStateMixin {
  LoginBloc bloc = LoginBloc();

  ContactoProvider _contactoProvider = ContactoProvider();
  ContactModel _contacto = ContactModel();
  MensajeProvider _mensajeProvider = MensajeProvider();
  int _selectedIndex;

  bool _toggled = false; // toggle button value
  List<SensorValue> _data = []; // array to store the values
  CameraController _controller;
  double _alpha = 0.3; // factor for the mean value
  AnimationController _animationController;
  double _iconScale = 1;
  int _bpm = 0; // beats per minute
  double _lastAvg = 0;
  int _fs = 30; // sampling frequency (fps)
  int _windowLen = 30 * 6; // window length to display - 6 seconds
  CameraImage _image; // store the last camera image
  double _avg; // store the average value during calculation
  DateTime _now; // store the now Datetime
  Timer _timer; // timer for image processing
  List<int> _bpmList = <int>[];
  int _bpmFinal = 0;
  bool _isEnable = false;
  double _prom;

  final firestoreInstance = FirebaseFirestore.instance;
  final _prefs = PreferenciasUsuario();

  TextStyle styleText = TextStyle(
    fontSize: 21.2,
    color: Colors.black,
  );

  @override
  void initState() {
    bloc.cargarContactos();
    bloc.cargarUsuario();
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController
      ..addListener(() {
        setState(() {
          _iconScale = 1.0 + _animationController.value * 0.4;
        });
      });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _toggled = false;
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  colors: [Colors.green[500], Colors.green[700]]),
              boxShadow: [BoxShadow(blurRadius: 0.0)],
              borderRadius: BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 40.0))),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Instrucciones",
                        style: styleText,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Text(
                    "1. Toque el ícono del centro y luego coloque su dedo.",
                    style: styleText,
                  ),
                  Text(
                    "2. Asegurese de que su dedo cobra el flash y la cámara principal.",
                    style: styleText,
                  ),
                  Text(
                    "3. Mantenga el dedo hasta que podamos calcular su ritmo cardiaco.",
                    style: styleText,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.center,
                            children: <Widget>[
                              _controller != null && _toggled
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: CameraPreview(_controller),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      color: Colors.grey,
                                    ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  _toggled
                                      ? "Cubra la cámara y el flash con su dedo"
                                      : "La cámara se mostrará aquí",
                                  style: TextStyle(
                                      backgroundColor: _toggled
                                          ? Colors.white
                                          : Colors.transparent),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Ritmo estimado",
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            (_bpmFinal > 30 && _bpmFinal < 150
                                ? _bpmFinal.toString() + " BPM"
                                : "--"),
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          RaisedButton(
                            color: Colors.greenAccent,
                            onPressed: () {
                              if (_bpmFinal > 0) {
                                _preguntar(context);
                              } else {
                                utils.mostrarAlerta(context,
                                    "No hay registro que guardar", "Alerta");
                              }
                            },
                            child: Text("GUARDAR REGISTRO"),
                          ),
                          RaisedButton(
                            color: Colors.redAccent,
                            onPressed: () => _preguntar2(context),
                            child: Text("ENVIAR ALERTA"),
                          ),
                        ],
                      )),
                    ),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Center(
                child: Transform.scale(
                  scale: _iconScale,
                  child: IconButton(
                    icon:
                        Icon(_toggled ? Icons.favorite : Icons.favorite_border),
                    color: Colors.red,
                    iconSize: 128,
                    onPressed: () {
                      if (_toggled) {
                        _untoggle();
                      } else {
                        _toggle();
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    border: Border.all(color: Colors.black),
                    color: Colors.white38),
                child: Chart(_data),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearData() {
    // create array of 128 ~= 255/2
    _data.clear();
    int now = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < _windowLen; i++)
      _data.insert(
          0,
          SensorValue(
              DateTime.fromMillisecondsSinceEpoch(now - i * 1000 ~/ _fs), 0));
  }

  void _toggle() {
    _clearData();
    _isEnable = true;
    _initController().then((onValue) {
      Wakelock.enable();
      _animationController?.repeat(reverse: true);
      setState(() {
        _toggled = true;
      });
      // after is toggled
      Future.delayed(Duration(seconds: 3)).then((value) {
        _initTimer();
        _updateBPM();
      });
    });
  }

  void _untoggle() {
    _disposeController();
    Wakelock.disable();
    _animationController?.stop();
    _animationController?.value = 0.0;
    setState(() {
      _toggled = false;
    });
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
  }

  Future<void> _initController() async {
    try {
      List _cameras = await availableCameras();
      _controller = CameraController(_cameras.first, ResolutionPreset.low);
      await _controller.initialize();
      Future.delayed(Duration(milliseconds: 200)).then((onValue) async {
        _controller.setFlashMode(FlashMode.torch);
      });
      _controller.startImageStream((CameraImage image) {
        _image = image;
      });
    } catch (Exception) {
      debugPrint(Exception);
    }
  }

  void _initTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000 ~/ _fs), (timer) {
      if (_toggled) {
        if (_image != null) _scanImage(_image);
      } else {
        timer.cancel();
      }
    });
  }

  void _scanImage(CameraImage image) {
    _now = DateTime.now();
    _avg =
        image.planes.first.bytes.reduce((value, element) => value + element) /
            image.planes.first.bytes.length;
    if (_data.length >= _windowLen) {
      _data.removeAt(0);
    }
    setState(() {
      _data.add(SensorValue(_now, _avg));
    });

    print("VALOR: " + _data[50].value.toString());
  }

  void _updateBPM() async {
    SensorValue max1, max2, max3, max4;
    List<int> listbpm = [];
    List<SensorValue> _values = [];
    int bpm;

    while (_toggled) {
      max1 = max2 = max3 = max4 = null;
      _prom = 0;
      _values = _data;
      max1 = valorMaximo(0, 21, _values);

      if (max1.value > 0) {
        max2 = valorMaximo(21, 42, _values);
        max3 = valorMaximo(42, 63, _values);
        max4 = valorMaximo(63, 83, _values);

        bpm = _calcularBPM(max1, max2);
        listbpm.add(bpm);
        bpm = _calcularBPM(max2, max3);
        listbpm.add(bpm);
        bpm = _calcularBPM(max3, max4);
        listbpm.add(bpm);

        listbpm.forEach((element) {
          _prom += element;
        });

        _prom = (_prom / 3);

        setState(() {
          _bpmFinal = _prom.toInt();
          _prom = 0;
          listbpm.clear();
        });
      }

      await Future.delayed(Duration(milliseconds: 1000 * _windowLen ~/ _fs));
    }
  }

  SensorValue valorMaximo(int inicio, int fin, List<SensorValue> list) {
    SensorValue max = SensorValue(_now, 0);

    for (int i = inicio; i < fin; i++) {
      if (list[i].value > max.value) max = list[i];
    }

    return max;
  }

  int _calcularBPM(SensorValue s1, SensorValue s2) {
    int diferencia =
        s2.time.millisecondsSinceEpoch - s1.time.millisecondsSinceEpoch;
    int bpm = (60000 ~/ diferencia);
    return bpm;
  }

  void _preguntar(BuildContext c) {
    showDialog(
      context: c,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Save"),
        content: Text("Desea guardar el presente registro?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("No")),
          TextButton(
              child: Text("Sí"),
              onPressed: () async {
                Navigator.of(context).pop();
                _guardarRegistro().whenComplete(() {
                  utils.mostrarAlerta(c, "Se ha guardado el registro", "Aviso");
                });
                Future.delayed(Duration(seconds: 2));
                Navigator.of(c).pop();
              }),
        ],
      ),
    );
  }

  Future<Widget> _preguntar2(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Seleccione uno de sus contactos"),
                content: _listaContactos(context, setState),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text("CANCELAR")),
                  FlatButton(
                    child: Text("SELECCIONAR"),
                    onPressed: () async {
                      var resp;

                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("CONFIRMACION"),
                              content:
                                  Text("Enviar mensaje a ${_contacto.name}?"),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("NO")),
                                FlatButton(
                                  onPressed: () async {
                                    String msg = "Hola " +
                                        _contacto.name +
                                        ", te informamos que " +
                                        bloc.user.name +
                                        " " +
                                        bloc.user.lastname +
                                        " tiene problemas de salud y necesita tu ayuda." +
                                        "Comunicate al: " +
                                        bloc.user.phoneNumber.toString();

                                    resp = await _mensajeProvider.enviarSms(
                                        _contacto.phoneNumber.toString(), msg);
                                    Navigator.of(context).pop();
                                    utils.mostrarAlerta(
                                        context, resp.toString(), "RESULTADO");
                                  },
                                  child: Text("SÍ"),
                                ),
                              ],
                            );
                          });
                    },
                  )
                ],
              );
            },
          );
        });
  }

  Future<Widget> _preguntarEstado(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              content: ListView(
                children: [],
              ),
            );
          },
        );
      },
    );
  }

  Widget _crearEstado(String estado) {
    return ListTile(
      key: UniqueKey(),
      title: Text(estado),
    );
  }

  Widget _listaContactos(BuildContext context, Function setState) {
    return FutureBuilder(
        future: _contactoProvider.cargarContactos(_prefs.idUser),
        builder: (context, AsyncSnapshot<List<ContactModel>> snapshot) {
          if (snapshot.hasData) {
            final lista = snapshot.data;
            return Container(
              height: 300.0,
              width: 300.0,
              child: ListView.builder(
                  itemCount: lista.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: UniqueKey(),
                      selected: index == _selectedIndex,
                      tileColor:
                          index == _selectedIndex ? Colors.greenAccent : null,
                      trailing: _selectedIndex == index
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      title: Text(lista[index].name),
                      subtitle: Text(lista[index].phoneNumber.toString()),
                      onTap: () {
                        if (_selectedIndex != index) {
                          setState(() {
                            _selectedIndex = index;
                            _contacto = lista[index];
                          });
                        }
                      },
                    );
                  }),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _crearItem(BuildContext context, ContactModel contacto, int index) {
    return ListTile(
      key: UniqueKey(),
      hoverColor: Colors.black,
      tileColor: index == _selectedIndex ? Colors.greenAccent : null,
      title: Text(contacto.name),
      subtitle: Text(contacto.phoneNumber.toString()),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Future<DocumentReference> _guardarRegistro() async {
    DateTime date = DateTime.now();
    var formatter = new DateFormat("yyyy-MM-dd");
    String formattedDate = formatter.format(date);

    RegistroModel reg = new RegistroModel();
    RegistroProvider rp = RegistroProvider();

    reg.fecha = formattedDate;
    reg.bpm = _bpmFinal;

    if (_bpmFinal > 150) {
      reg.alerta = "Alerta máxima";
    } else {
      if (_bpmFinal <= 150 && _bpmFinal > 100) {
        reg.alerta = "Alerta media";
      } else {
        reg.alerta = "Normal";
      }
    }

    var res = await rp.agregarRegistro(_prefs.idUser, reg);
    print(res.toString());

    return res;
  }
}
