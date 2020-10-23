
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:simoric/src/pages/widgets/mainDrawer.dart';
 
import 'package:simoric/src/pages/widgets/headerWidget.dart'; 

class RecomendacionesPage extends StatelessWidget { 

    static final routeName = "RecomendacionesPage"; 

    String ruta = "assets/swiper/"; 
    static final _estiloTitulo = TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.lightGreenAccent);
    static final _estiloParrafo = TextStyle(fontSize: 18.0, height: 1.25);

    static final String consideracion1 = "1. Normalmente, el corazón late entre 60 y 100 veces por minuto."
                                         "En las personas que hacen ejercicio habitualmente o que toman"
                                         "medicamentos para reducir el ritmo cardíaco, la frecuencia puede"
                                         "caer por debajo de 60 latidos por minuto.";

    static final String consideracion2 = "2. Si su frecuencia cardíaca es rápida  (más de 100 latidos por minuto), se denomina taquicardia. Una frecuencia cardíaca de menos de 60 se denomina bradicardia. Un latido cardíaco adicional se conoce como extrasístole.";
    static final String consideracion3 = "3. Las palpitaciones no son graves la mayoría de las veces. Las sensaciones que representan un ritmo cardíaco anormal (arritmia) pueden ser más serias.";

   
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 1.5;

    List<Widget> list = [
        _crearItem("Reduzca la ingesta de cafeína y nicotina. Esto a menudo disminuirá las palpitaciones cardíacas.", ruta+"1.png"),
        _crearItem("Aprenda a reducir el estrés y la ansiedad. Esto puede ayudar a prevenir las palpitaciones cardíacas y ayudarle a manejarlas mejor cuando se presenten.", ruta+"2.jpg"),
        _crearItem("Ensaye con ejercicios de respiración o relajación profunda.", ruta+"3.jpg"),
        _crearItem("Practique yoga, meditación o taichí.", ruta+"4.jpg"),
        _crearItem("Haga ejercicio de manera regular.", ruta+"5.jpeg"), 
        _crearItem("No fume.", ruta+"6.jpg")
    ];

        return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                 elevation: 0.0,
              ), 
              body: SingleChildScrollView(
                  child: Column(
                      children: [ 
                          HeaderWidget(size: size, text: "¿Qué hacemos si hay \n alteriaciones del ritmo?",),
                          SizedBox(height: 20.0,),
                          Text("Consideraciones",style: _estiloTitulo,),
                          _consideraciones(),
                          SizedBox(height: 20.0),
                          Text("Recomendaciones", style: _estiloTitulo,),
                          SizedBox(height: 15.0),
                          _swiper(list),
                          SizedBox(height: 30.0,),
                          
                      ],  
                  ),
              ),
            drawer: Drawer(
               child: MainDrawer(),
            ),
          ),
        );
    
  }

  Widget _consideraciones(){
      
        return Container(
             height: 400.0,
             width: 500.0, 
             padding: EdgeInsets.all(15.0),
             child: Card(
                 elevation: 10.0,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                 margin: EdgeInsets.all(15.0),
                 child: SingleChildScrollView(
                      child: Padding(
                         padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                         child: Column(
                           children: [
                               SizedBox(height: 20.0,),
                               Text(consideracion1,style: _estiloParrafo, textAlign: TextAlign.justify,),
                               Divider(color: Colors.lightGreenAccent, height: 20.0,),
                               Text(consideracion2,style: _estiloParrafo, textAlign: TextAlign.justify,),
                               Divider(color: Colors.lightGreenAccent, height: 20.0,), 
                               Text(consideracion3,style: _estiloParrafo, textAlign: TextAlign.justify,)

                           ],
                        ),
                      ),
                 ),
             ),
        );
  }

  Widget _swiper(List<Widget> list){
        return SizedBox(
            width: 350,
            height: 400,
            child: Swiper(
             itemCount: list.length,
             indicatorLayout: PageIndicatorLayout.COLOR,
             autoplay: true,
             pagination: new SwiperPagination(),
             control: new SwiperControl(),
             itemBuilder: (BuildContext context, int index){
                 return list[index];
             },
          ),
        );
  }

  Widget _crearItem(String text, String image){

          return Container(
              width: 300,
              height: 400,
              
              child: Column(
                  children: [
                       Image(
                          image: AssetImage(image),
                          fit: BoxFit.fill,

                         ),
                       Divider(color: Colors.green,),
                       Text(text),
                  ],
              ),
        );
  }
}


