import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/pages/pagina_principal.dart';

class PaginaCrearUsuario extends StatelessWidget {
  String nombre = '';
  String apellido = '';
  int telefono = 0;
  String correo = '';
  String comprobarPass = "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Creacion de Usuario')),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/fondos/fondo_login.jpg"),
                  fit: BoxFit.cover)),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Nombre de Usuario",
                        labelStyle: TextStyle(color: Colors.white)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo vacío';
                      }

                      if (value.length < 3) {
                        return 'Usuario demasido corto';
                      }
                    },
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Telefono",
                          labelStyle: TextStyle(color: Colors.white)),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          if (value.length < 9) {
                            return 'El formato no coincide con un número de teléfono';
                          }

                          if (value.length > 9) {
                            return 'El formato no coincide con un número de teléfono';
                          }
                          return 'Campo Vacío';
                        }
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Correo",
                          labelStyle: TextStyle(color: Colors.white)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo vacío';
                        }
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Contraseña",
                          labelStyle: TextStyle(color: Colors.white)),
                      //Esta propiedad sirve para que nos oculte el texto (formato contraseña)
                      obscureText: true,
                      validator: (value) {
                        //Guardamos la contraseña en una variable
                        comprobarPass = value.toString();

                        //Si el campo esta vacio...
                        if (value!.isEmpty) {
                          return 'Campo vacío';
                        }
                      }),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: "Repetir Contraseña",
                          labelStyle: TextStyle(color: Colors.white)),
                      //Esta propiedad sirve para que nos oculte el texto (formato contraseña)
                      obscureText: true,
                      validator: (value) {
                        //Comparamos que las contraseñas son iguales
                        if (comprobarPass != value) {
                          return 'Las contraseñas no coinciden';
                        }
                        if (value!.isEmpty) {
                          return 'Campo vacío';
                        }
                      }),
                  OutlinedButton(
                      onPressed: () => recogerDatos(context),
                      child: Text(
                        'Registrarme',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )),
        ));
  }

  recogerDatos(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.of(context).pushNamed("/");
    }
  }
}
