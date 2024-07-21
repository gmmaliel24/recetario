import 'package:flutter/material.dart';
import 'package:proyecto_recetario/pantallas/inicio_sesion.dart';
import 'package:proyecto_recetario/pantallas/pantallaInicio.dart';
import 'package:proyecto_recetario/pantallas/registro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: 'homePage',
      routes: {
        'homePage': (context) => Pantallainicio(),
        'iniarSesion': (context) => InicioSesion(),
        'registrarse': (context) => Registro(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
