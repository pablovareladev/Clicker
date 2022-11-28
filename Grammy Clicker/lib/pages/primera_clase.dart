import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/pages/pagina_principal.dart';

class PrimeraClase extends StatelessWidget {
  String usuario = "";
  String password = "";

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
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
                        labelText: "Nombre de usuario",
                        labelStyle: TextStyle(color: Colors.white)),
                    onSaved: (value) {
                      usuario = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo vacio';
                      } else if (value.length < 3) {
                        return 'Usuario demasido corto';
                      } else if (value.length > 25) {
                        return 'Usuario demasiado largo';
                      }
                    },
                  ),
                  TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Contraseña",
                          labelStyle: TextStyle(color: Colors.white)),
                      //Esta propiedad sirve para que nos oculte el texto (formato contraseña)
                      obscureText: true,
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo vacio';
                        }
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  //boton para ir a la siguiente pagina
                  OutlinedButton(
                    onPressed: () => mostrarPaginaPrincipal(context),
                    child: Text('Iniciar Sesión',
                        style: TextStyle(color: Colors.black)),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '¿No tienes una cuenta? ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      TextSpan(
                          text: 'Crear cuenta',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 85, 154),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              mostrarPaginaCrearUsuario(context);
                            }),
                    ]),
                  ),
                ],
              )),
        ));
  }

  mostrarPaginaPrincipal(BuildContext context) {
    //Si los campos estan correctos nos lleva a la siguiente pagina
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Navigator.of(context).pushNamed("/paginaPrincipal",
          arguments: Persona(usuario: usuario, password: password));
    }
  }

  mostrarPaginaCrearUsuario(BuildContext context) {
    //nos lleva a la pagina con el formulario completo
    Navigator.of(context).pushNamed("/paginaCrearUsuario");
  }
}
