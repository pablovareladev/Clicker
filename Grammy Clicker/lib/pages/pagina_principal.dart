import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

//StatefulWidget esto es para cambiar la interfaz al momento
class SegundaClase extends StatefulWidget {
  @override
  PaginaPrincipal createState() => PaginaPrincipal();
}

class PaginaPrincipal extends State<SegundaClase> {
//STACK TIENE CHILDREN Y SIRVE PARA SOBREPONER ELEMENTOS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    compraDiscos();
    apareceArianaGrande();
  }

  //GRAMMYS
  String grammysMostrar = "";
  int grammys = 0; //grammys que tiene el usuario
  int grammysSegundo = 0;

//ADELE
  int contAdele = 0; //Numero de x que tienes
  int precioAdele = 100; //precio base, irá aumentando
  bool adele = false; //para ver si puede comprarlo

//SIA
  int contSia = 0; //Numero de x que tienes
  int precioSia = 500; //precio base, irá aumentando
  bool sia = false; //para ver si puede comprarlo

//LADY GAGA
  int contGaga = 0; //Numero de x que tienes
  int precioGaga = 1500; //precio base, irá aumentando
  bool gaga = false; //para ver si puede comprarlo

//MILEY
  int contMiley = 0; //Numero de x que tienes
  int precioMiley = 4500; //precio base, irá aumentando
  bool miley = false; //para ver si puede comprarlo

//HARRY
  int contHarry = 0; //Numero de x que tienes
  int precioHarry = 10000; //precio base, irá aumentando
  bool harry = false; //para ver si puede comprarlo

  //DISCOS
  //boolean para saber cuando activar el timer (primera vez que compra discos)
  bool tieneDiscos = false;
  //ORO
  int contDiscosOro = 0;
  int precioDiscosOro = 700;


  //PLATINO
  int contDiscosPlatino = 0;
  int precioDiscosPlatino = 1500;

  //URANIO
  int contDiscosUranio = 0;
  int precioDiscosUranio = 2500;

  //DIAMANTE
  int contDiscosDiamante = 0;
  int precioDiscosDiamante = 4000;

  //IMAGEN ALEATORIA
  String url = "assets/images/ariana/vacio.png";
  //ponemos +1 porque si no lar coordenadas con 0 petan
  int ariLeft = Random().nextInt(380) + 1;
  int ariTop = Random().nextInt(480) + 1;

  int arianaBN = Random().nextInt(10);

  bool arianaVisible = true;
  bool arianaPulsable = true;

  //AUDIO
  AudioPlayer player = AudioPlayer();
  AudioPlayer sonidosGrammy = AudioPlayer();
  


  @override
  Widget build(BuildContext context) {
    final persona = ModalRoute.of(context)!.settings.arguments as Persona;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/fondos/fondo_principal.jpg"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Grammy Clicker'),
          centerTitle: true,
          actions: [
            OutlinedButton(
                onPressed: () => cerrarSesion(context),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                height: 25,
              ),

//nombre del usuario que se mostrará
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  //Llamamos al metodo Persona
                  persona.usuario,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              //imagen principal donde se va a hacer click
              Padding(
                  padding: const EdgeInsets.only(top: 100, left: 70),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          grammys = hacerClick(grammys);                 
                        });

                        //llamamos a la funcion
                        grammyAudio();         
                      },
                      child: Image(
                        image: AssetImage('assets/images/clicker/grammy_borde.png'),
                        fit: BoxFit.cover,
                        height: 350,
                      ))),
                      

              Padding(
                  padding: const EdgeInsets.only(top: 490, left: 115),
                  child: Stack(
                    children: [
                      // The text inside
                      Text(
                        'Grammys: ' + grammys.toString(),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  )),

              Padding(
                padding: const EdgeInsets.only(top: 530, left: 170),
                child: Text(
                  "Por segundo: " + grammysSegundo.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 248, 193, 73),
                  ),
                ),
              ),

              // //IMAGEN DE ARIANA GRANDE
              Padding(
                padding: EdgeInsets.only(
                  //le damos las coordenadaas del random to double.
                  left: ariLeft.toDouble(),
                  top: ariTop.toDouble(),
                ),
                child: AnimatedOpacity(
                    // Si el Widget debe ser visible, anime a 1.0 (completamente visible). Si
                    // el Widget debe estar oculto, anime a 0.0 (invisible).
                    opacity: arianaVisible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    // El cuadro verde debe ser el hijo de AnimatedOpacity
                    child: IconButton(
                      iconSize: 100,
                      icon: Image(
                        image: AssetImage(url),
                      ),
                      //si arianaPulsable es true en el onpressed se cambia a false si no, a null
                      onPressed: arianaPulsable ? () {
                        //una vez la pulse la hacemos desaparecer
                        arianaVisible = false;
                        //una vez pulsada no se puede pulsar mas veces
                        arianaPulsable = false;
                        //llamamos a la funcion para ver si le beneficia o no
                        arianaBuffNerf();
                        arianaAudio();
                      }
                      //null del onPressed de la ternaria
                    : null)),
              ),
            ],
          ),
        ),
        //mostramos el drawer
        drawer: getDrawer(context),
      ),
    );
  }

  //desplegable para la tienda
  getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Tienda"),
            leading: Icon(Icons.shop),
          ),

//ADELE
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color:
                        Color.fromARGB(255, 172, 112, 1), //Color del contenedor
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/artistas/adele.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 122, top: 10), //mover texto Adele
                        child: Text(
                          "Adele\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contAdele.toString(), //EL texto del contador de Adele
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 120, top: 40),
                        child: Text(
                          "Precio: " +
                              precioAdele.toString(), //EL texto del precio de Adele
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 125, top: 80), //mover texto descriptivo
                        child: Text(
                          "Te potencia el click +1",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              //llamamos a la funcion
              comprobarAdele();
            },
          ),
          //SIA
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 112, 1),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Image(
                        image: AssetImage('assets/images/tienda/artistas/sia.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 125, top: 10), //mover texto sia
                        child: Text(
                          "Sia\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contSia.toString(), //EL texto del contador de Sia
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 125, top: 40),
                        child: Text(
                          "Precio: " +
                              precioSia.toString(), //EL texto del precio de Sia
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 120, top: 80), //mover texto descriptivo
                        child: Text(
                          "Te potencia el click +2",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                //llamamos a la funcion de sia
                comprobarSia();
              });
            },
          ),

//LADY GAGA
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 112, 1),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/artistas/gaga.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 10),
                        child: Text(
                          "Lady Gaga\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contGaga
                              .toString(), //EL texto del contador de LAdy GAGa
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 40),
                        child: Text(
                          "Precio: " +
                              precioGaga.toString(), //EL texto del precio de Lady Gaga
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 80),
                        child: Text(
                          "Te potencia el click +4", //mover texto descriptivo
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                //llamamos a la funcion
                comprobarGaga();
              });
            },
          ),

//MILEY CYRUS
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 112, 1),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/artistas/miley.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 10),
                        child: Text(
                          "Miley Cyrus\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contMiley.toString(), //EL texto del contador de Miley
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 40),
                        child: Text(
                          "Precio: " +
                              precioMiley.toString(), //EL texto del precio de Miley
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 90, top: 80), //mover texto descriptivo
                        child: Text(
                          "Te potencia el click +7",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                //Llamamos a la funcion
                comprobarMiley();
              });
            },
          ),

//HARRY STYLES
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 112, 1),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/artistas/harry.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 10),
                        child: Text(
                          "Harry Styles\n",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contHarry.toString(), //EL texto del contador de Harry
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 90, top: 40),
                        child: Text(
                          "Precio: " +
                              precioHarry.toString(), //EL texto del precio de Harry
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 90, top: 80), //mover texto descriptivo
                        child: Text(
                          "Te potencia el click +10",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                //Llamamos a la funcion
                comprobarHarry();
              });
            },
          ),

          //DISCOS

//DISCO DE ORO
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 146, 14, 14),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/discos/oro.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 95, top: 10),
                        child: Text(
                          "Disco de Oro\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contDiscosOro
                              .toString(), //EL texto del contador de disco Oro
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 102, top: 40),
                        child: Text(
                          "Precio: " +
                              precioDiscosOro.toString(), //EL texto del precio de disco Oro
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 90, top: 80), //mover texto descriptivo
                        child: Text(
                          "Genera pasivamente 1 grammy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                //por si compra un disco
                tieneDiscos = true;
              });
              // compraDiscos(tieneDiscos);
              comprobarDiscoOro();
            },
          ),

//DISCO DE PLATINO
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 146, 14, 14),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/discos/platino.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 97, top: 10), //mover texto disco Platino
                        child: Text(
                          "Disco de Platino\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contDiscosPlatino
                              .toString(), //EL texto del contador de Disco Platino
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 102, top: 40),
                        child: Text(
                          "Precio: " +
                              precioDiscosPlatino.toString(), //EL texto del precio de disco Platino
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 92, top: 80), //mover texto descriptivo
                        child: Text(
                          "Genera pasivamente 3 grammy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                tieneDiscos = true;
              });
              //Llamamos a la funcion
              // compraDiscos(tieneDiscos);
              comprobarDiscosPlatino();
            },
          ),

//DISCO URANIO
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 146, 14, 14),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/discos/uranio.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 97, top: 10), //mover texto disco uranio
                        child: Text(
                          "Disco de Uranio\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contDiscosUranio
                              .toString(), //EL texto del contador de Disco Uranio
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 102, top: 40),
                        child: Text(
                          "Precio: " +
                              precioDiscosUranio.toString(), //EL texto del precio de disco Uranio
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 92, top: 80), //mover texto descriptivo
                        child: Text(
                          "Genera pasivamente 7 grammy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                tieneDiscos = true;
              });
              //Llamamos a la funcion
              // compraDiscos(tieneDiscos);
              comprobarDiscosUranio();
            },
          ),
//DIAMANTE
          InkWell(
            child: Container(
                height: 100,
                width: 304,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 146, 14, 14),
                    border: Border.all(
                        color: Color.fromARGB(255, 0, 0, 0), width: 1)),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                        image: AssetImage('assets/images/tienda/discos/diamante.png'),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 97, top: 10), //mover texto
                        child: Text(
                          "Disco de Diamante\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 255, top: 5),
                        child: Text(
                          contDiscosDiamante
                              .toString(), //EL texto del contador de Disco Diamantes
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 102, top: 40),
                        child: Text(
                          "Precio: " +
                              precioDiscosDiamante.toString(), //EL texto del precio de Disco Diamantes
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 92, top: 80),
                        child: Text(
                          "Genera pasivamente 15 grammy",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                )),
            onTap: () {
              setState(() {
                tieneDiscos = true;
              });
              //Llamamos a las funciones
              // compraDiscos(tieneDiscos);

              comprobarDiscosDiamante();
            },
          ),
        ],
      ),
    );
  }

  compraDiscos() {
    //TIMER
    Timer? timer;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        grammys += contDiscosOro;
        grammys += (contDiscosPlatino * 3);
        grammys += (contDiscosUranio * 7);
        grammys += (contDiscosDiamante * 15);
      });
    });
  }

//cada vez que compremos una mejora, aumenta el precio
//llamamos a la funcion cada vez que pulsamos en una compra
  comprobarAdele() {
    //comprobamos que tiene grammys suficientes
    setState(() {
      if (grammys >= precioAdele) {
        //aumentamos el precio de la siguiente x
        grammys -= precioAdele.toInt();
        precioAdele = (precioAdele * 1.3).toInt();
        contAdele++;
        adeleAudio();
      }
    });
  }

  comprobarSia() {
    setState(() {
      if (grammys >= precioSia) {
        grammys -= precioSia.toInt();
        precioSia = (precioSia * 1.3).toInt();
        contSia++;
        siaAudio();
      }
    });
  }

  comprobarGaga() {
    setState(() {
      if (grammys >= precioGaga) {
        grammys -= precioGaga.toInt();
        precioGaga = (precioGaga * 1.3).toInt();
        contGaga++;
        gagaAudio();
      }
    });
  }

  comprobarMiley() {
    setState(() {
      if (grammys >= precioMiley) {
        grammys -= precioMiley.toInt();
        precioMiley = (precioMiley * 1.3).toInt();
        contMiley++;
        mileyAudio();
      }
    });
  }

  comprobarHarry() {
    setState(() {
      if (grammys >= precioHarry) {
        grammys -= precioHarry.toInt();
        precioHarry = (precioHarry * 1.3).toInt();
        contHarry++;
        harryAudio();
      }
    });
  }

  //DISCOS
  comprobarDiscoOro() {
    setState(() {
      if (grammys >= precioDiscosOro) {
        grammys -= precioDiscosOro.toInt();
        precioDiscosOro = (precioDiscosOro * 1.3).toInt();
        contDiscosOro++;
        grammysPorSegundo();
      }
    });
  }

  comprobarDiscosPlatino() {
    setState(() {
      if (grammys >= precioDiscosPlatino) {
        grammys -= precioDiscosPlatino.toInt();
        precioDiscosPlatino = (precioDiscosPlatino * 1.5).toInt();
        contDiscosPlatino++;
        grammysPorSegundo();
      }
    });
  }

  comprobarDiscosUranio() {
    setState(() {
      if (grammys >= precioDiscosUranio) {
        grammys -= precioDiscosUranio.toInt();
        precioDiscosUranio = (precioDiscosUranio * 1.7).toInt();
        contDiscosUranio++;
        grammysPorSegundo();
      }
    });
  }

  comprobarDiscosDiamante() {
    setState(() {
      if (grammys >= precioDiscosDiamante) {
        grammys -= precioDiscosDiamante.toInt();
        precioDiscosDiamante = precioDiscosDiamante * 2;
        contDiscosDiamante++;
        grammysPorSegundo();
      }
    });
  }

//cada vez que pulsemos en una mejora, comprobará si puede comprarla
  comprobarGrammysSuficientes(int grammys) {}

//al hacer click comprueba cuanto tiene que sumar.
  int hacerClick(int grammys) {
    grammys++;
    grammys = grammys + (contAdele * 1);
    grammys = grammys + (contSia * 2);
    grammys = grammys + (contGaga * 4);
    grammys = grammys + (contMiley * 7);
    grammys = grammys + (contHarry * 10);

    return grammys;
  }

  grammysPorSegundo() {
    setState(() {
      grammysSegundo = contDiscosOro +
          (contDiscosPlatino * 3) +
          (contDiscosUranio * 7) +
          (contDiscosDiamante * 15);
    });
  }

  apareceArianaGrande() {
    //timer para ariana
    Timer? ariana;

    ariana = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {
        ariLeft = Random().nextInt(380) + 1;
        ariTop = Random().nextInt(480) + 1;

        //hacemos que se vea ariana cada X
        arianaVisible = true;
        //hacemos que se pueda pulsar ariana grande
        arianaPulsable = true;

        arianaBN = Random().nextInt(10);
        // si el multiplo de 5 sale la mala
        if (arianaBN % 5 == 0) {
          url = "assets/images/ariana/arianan.png";
          //si no, sale la buena
        } else {
          url = "assets/images/ariana/arianab.png";
        }

//se inicia este timer una vez aparezca ariana para que desaparezca al rato
        Timer quitarArinana = Timer(const Duration(seconds: 5), () {
          arianaVisible = false;
          arianaPulsable = false;
        });
      });
    });
  }

  arianaBuffNerf(){
    if(url == "assets/images/ariana/arianab.png" && grammys == 0){
      grammys = grammys + 5200;
    }
    //aqui le potenciamos
    if(url == "assets/images/ariana/arianab.png"){
      //le aumenta un 15% de los grmmys que ya tenías
      grammys = grammys + (grammys / 10).toInt() * 2;

    }else if (url == "assets/images/ariana/arianan.png"){
      //aqui hacemos que pierda un 30 % grammys...
      grammys = (grammys / 10).toInt() * 7;
    }
  }

  arianaAudio(){
    //Funcion que pondra un audio aleatorio
    int arianaAudioRandom = Random().nextInt(4) + 1;
    if(url == "assets/images/ariana/arianab.png" && arianaAudioRandom == 1){
       player.play(AssetSource("audio/arianab1.mp3"));
    }
    if(url == "assets/images/ariana/arianab.png" && arianaAudioRandom == 2){
       player.play(AssetSource("audio/arianab2.mp3"));
    }
    if(url == "assets/images/ariana/arianab.png" && arianaAudioRandom == 3){
       player.play(AssetSource("audio/arianab3.mp3"));
    }
    if(url == "assets/images/ariana/arianab.png" && arianaAudioRandom == 4){
       player.play(AssetSource("audio/arianab4.mp3"));
    }
    //si sale la ariana mala
    if(url == "assets/images/ariana/arianan.png"){
       player.play(AssetSource("audio/arianan1.mp3"));
    }
  }


//AUDIOS ALEATORIOS PARA EL GRAMMY
  grammyAudio(){
    int randomGrammyAudio = Random().nextInt(15) + 1;
    if(randomGrammyAudio <= 5){
      sonidosGrammy.play(AssetSource("audio/grammy1.mp3"));
    }
    if (randomGrammyAudio > 5 && randomGrammyAudio <= 10){
       sonidosGrammy.play(AssetSource("audio/grammy2.mp3"));
    }
    if (randomGrammyAudio > 10 && randomGrammyAudio <= 15){
       sonidosGrammy.play(AssetSource("audio/grammy3.mp3"));
    }
  }

//AUDIOS ALEATORIOS DE LOS ARTISTAS
  adeleAudio(){
    int randomAudioArtistas = Random().nextInt(10) + 1;
    if(randomAudioArtistas > 5){
      player.play(AssetSource("audio/adele1.mp3"));

    }
    if (randomAudioArtistas < 5){
       player.play(AssetSource("audio/adele2.mp3"));
    }
  }

  siaAudio(){
    int randomAudioArtistas = Random().nextInt(10) + 1;
    if(randomAudioArtistas > 5){
      player.play(AssetSource("audio/sia1.mp3"));

    }
    if (randomAudioArtistas < 5){
       player.play(AssetSource("audio/sia2.mp3"));
    }
  }

  gagaAudio(){
    int randomAudioArtistas = Random().nextInt(10) + 1;
    if(randomAudioArtistas > 5){
      player.play(AssetSource("audio/gaga1.mp3"));

    }
    if (randomAudioArtistas < 5){
       player.play(AssetSource("audio/gaga2.mp3"));
    }
  }

  mileyAudio(){
    int randomAudioArtistas = Random().nextInt(10) + 1;
    if(randomAudioArtistas <= 4){
      player.play(AssetSource("audio/miley1.mp3"));

    }
    if (randomAudioArtistas > 3 && randomAudioArtistas < 7){
       player.play(AssetSource("audio/miley2.mp3"));
    }

    if (randomAudioArtistas > 7 && randomAudioArtistas < 10){
       player.play(AssetSource("audio/miley3.mp3"));
    }
  }

  harryAudio(){
    int randomAudioArtistas = Random().nextInt(10) + 1;
    if(randomAudioArtistas > 5){
      player.play(AssetSource("audio/harry1.mp3"));

    }
    if (randomAudioArtistas < 5){
       player.play(AssetSource("audio/harry2.mp3"));
    }
  }
}

cerrarSesion(BuildContext context) {
  Navigator.of(context).pushNamed("/");
}

class Persona {
  String usuario = "";
  String password = "";

  Persona({
    required this.usuario,
    required this.password,
  });
}
