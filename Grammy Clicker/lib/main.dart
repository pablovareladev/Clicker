import 'package:flutter/material.dart';
import '/pages/paginaCrearUsuario.dart';
import '/pages/primera_clase.dart';
import '/pages/pagina_principal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => PrimeraClase(),
        "/paginaPrincipal": (BuildContext context) => SegundaClase(),
        "/paginaCrearUsuario": (BuildContext context) => PaginaCrearUsuario(),
      },
    );
  }
}
