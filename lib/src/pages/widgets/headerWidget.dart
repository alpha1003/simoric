import 'package:flutter/material.dart';
import 'package:simoric/src/pages/constant.dart';
import 'package:simoric/src/preferencias_usuario/preferencias_usuario.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key key,
    @required this.size,
    @required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    final _prefs = PreferenciasUsuario();
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
              gradient: LinearGradient(colors: [
                Color.fromRGBO(162, 243, 26, 1),
                Color.fromRGBO(25, 217, 50, 1)
              ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 120.0,
                        width: 120.0,
                        child: Image.asset("assets/mascota.png"),
                      ),
                      Text(
                        '$text',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
