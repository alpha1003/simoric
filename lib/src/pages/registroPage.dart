import 'package:flutter/material.dart';
import 'package:simoric/src/bloc/login_bloc.dart';
import 'package:simoric/src/bloc/provider.dart';
import 'package:simoric/src/pages/homePage.dart';
import 'package:simoric/src/pages/login_page.dart';
import 'package:simoric/src/provider/usuarioProvider.dart';
import 'package:simoric/src/utils/utils.dart' as utils;


class RegistroPage extends StatefulWidget {

  static final String routeName = "RegistroPage"; 

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final usuarioProvider = new UsuarioProvider(); 

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo( context ),
          _loginForm( context ),
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text("Crear cuenta", style: TextStyle(fontSize: 20.0)),
                SizedBox( height: 60.0 ),
                _crearEmail( bloc ),
                SizedBox( height: 30.0 ),
                _crearPassword( bloc ),
                SizedBox( height: 30.0 ),
                _crearNombre(),
                 SizedBox( height: 30.0 ),
                _crearApellido(),
                 SizedBox( height: 30.0 ),
                _crearEdad(),
                  SizedBox( height: 30.0 ),
                _crearBoton( bloc )
              ],
            ),
          ),

          FlatButton(
            child: Text("¿Ya tienes cuenta? Login"),
            onPressed: () => Navigator.pushReplacementNamed(context, LoginPage.routeName),
          ),
          SizedBox( height: 100.0 )
        ],
      ),
    );


  }

  Widget _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),

        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.lightGreen ),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
            counterText: snapshot.data,
            errorText: snapshot.error
          ),
          onChanged: bloc.changeEmail,
        ),

      );


      },
    );


  }

  Widget _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.lightGreen ),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),

        );

      },
    );


  }

  Widget _crearNombre(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            icon: Icon( Icons.perm_contact_calendar, color: Colors.lightGreen ),
            hintText: 'Tu nombre',
            labelText: 'Nombre',
          ),
          
        ),

      );
  }

 Widget _crearApellido(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            icon: Icon( Icons.perm_contact_calendar, color: Colors.lightGreen ),
            hintText: 'Tu apellido',
            labelText: 'Apellido',
          ),
          
        ),

      );
  }

  Widget _crearEdad(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            icon: Icon( Icons.perm_contact_calendar, color: Colors.lightGreen ),
            hintText: 'Tu edad',
            labelText: 'Edad',
          ),
          
        ),

      );
  }   

  Widget _crearBoton( LoginBloc bloc) {

    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
            child: Text('Registrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? ()=> _registrer(bloc, context) : null
        );
      },
    );
  }

  _registrer(LoginBloc bloc, BuildContext context) async {

    Map info = await usuarioProvider.nuevoUsuario(bloc.email, bloc.password); 

    if( info["ok"]){
        Navigator.pushReplacementNamed(context, HomePage.routeName);
    }else{

        utils.mostrarAlerta(context, info["mensaje"]);
    }
  }

  Widget _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(42, 173, 16, 1.0),
            Color.fromRGBO(45, 219, 11, 1.0)
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.15)
      ),
    );


    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned( top: 70.0, left: 30.0, child: circulo ),
        Positioned( top: -30.0, right: -20.0, child: circulo ),
        Positioned( bottom: -50.0, right: -10.0, child: circulo ),
        Positioned( bottom: 120.0, right: 20.0, child: circulo ),
        Positioned( bottom: -50.0, left: -20.0, child: circulo ),
        
        Container(
          padding: EdgeInsets.only(top: 100.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage("assets/logo.png"),width: 350.0, height: 150.0,),
              //Icon( Icons, color: Colors.white, size: 100.0 ),
              SizedBox( height: 10.0, width: double.infinity ),
             
            ],
          ),
        )

      ],
    );

  }
}