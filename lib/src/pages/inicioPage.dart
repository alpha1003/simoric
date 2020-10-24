import 'package:flutter/material.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/pages/widgets/headerWidget.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

import 'widgets/mainDrawer.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      drawer: Drawer(
        child: MainDrawer(),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
  );
}

class Body extends StatelessWidget { 
  PreferenciasUsuario _prefs = PreferenciasUsuario(); 
   
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size * 1.5;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWidget(size: size, text: "Bienvenido ${_prefs.nombre}",),
          TituloConBoton(title: "Recomendaciones", press: () {}),
          Recomendados(),
          TituloConBoton(title: "¿Como te sientes hoy?", press: () {}),
          Emojis(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}

class TituloConBoton extends StatelessWidget {
  const TituloConBoton({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: <Widget>[
          SubrayadoPersonalizado(text: title),
          Spacer(),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: kPrimaryColor,
            onPressed: press,
            child: Text(
              "More",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class SubrayadoPersonalizado extends StatelessWidget {
  const SubrayadoPersonalizado({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding / 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(right: kDefaultPadding / 4),
              height: 7,
              color: kPrimaryColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}

class Recomendados extends StatelessWidget {
  const Recomendados({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          TarjetaRecomendados(
            image: "assets/iconos/080-running.png",
            title: "Trotar",
            press: () {},
          ),
          TarjetaRecomendados(
            image: "assets/iconos/082-salad.png",
            title: "Comer sano",
            press: () {},
          ),
          TarjetaRecomendados(
            image: "assets/iconos/046-doctor.png",
            title: "Ir al medico",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class Emojis extends StatelessWidget {
  const Emojis({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          TarjetaRecomendados(
            image: "assets/emojis/001-happy.png",
            title: "Feliz",
            press: () {},
          ),
          TarjetaRecomendados(
            image: "assets/emojis/009-sad.png",
            title: "Triste",
            press: () {},
          ),
          TarjetaRecomendados(
            image: "assets/emojis/023-angry.png",
            title: "Enojado",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class TarjetaRecomendados extends StatelessWidget {
  const TarjetaRecomendados({
    Key key,
    this.image,
    this.title,
    this.press,
  }) : super(key: key);

  final String image, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
