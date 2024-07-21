// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/pantallas/recetas.dart';
import 'package:proyecto_recetario/pantallas/registro.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({super.key});

  @override
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _iniarSesion() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, ingrese su correo y contrasseña'),
          ),
        );
        return;
      }

      bool autenticado =
          await RecetaBasesDeDatos.auntenticarUsuario(email, password);

      dynamic idUser = await RecetaBasesDeDatos.idUser(email, password);

      if (autenticado) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecetasUsuario(
              id: idUser,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Correo o contraseña incorrectos'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al Iniciar Sesión'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 50,
                    ),
                    Text(
                      'TastyRecipes',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Usuario o Correo',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 25.0),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text('Contraseña',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffix: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        )),
                    obscureText: _obscureText,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿No tienes una cuenta?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registro(),
                        ),
                      );
                    },
                    child: const Text(
                      'Registrate',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _iniarSesion();
                },
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black),
                  side: WidgetStateProperty.all(
                      const BorderSide(color: Colors.black, width: 2)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
