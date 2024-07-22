// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';

class MenuUsuario extends StatefulWidget {
  final int id;
  const MenuUsuario({super.key, required this.id});

  @override
  _MenuUsuarioState createState() => _MenuUsuarioState();
}

class _MenuUsuarioState extends State<MenuUsuario> {
  Usuario? auxUser;

  @override
  void initState() {
    super.initState();
    setState(() {
      _cargarDatos();
    });
  }

  Future<void> _cargarDatos() async {
    try {
      Usuario? datos = await RecetaBasesDeDatos.readIdUser(widget.id);
      setState(() {
        auxUser = datos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Fallo la carga de Datos de Usuario $e'),
        ),
      );
    }
  }

  CircleAvatar _convertirImagen(String imgString) {
    try {
      if (imgString.isNotEmpty) {
        return CircleAvatar(
          radius: 50,
          backgroundImage: FileImage(File(imgString)),
        );
      } else {
        return const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn.pixabay.com/photo/2021/11/24/05/19/user-6820232_960_720.png'),
          radius: 50,
        );
      }
    } catch (e) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(base64Decode(imgString)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (auxUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Drawer(
        width: 350,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      _convertirImagen(auxUser!.fotoUsuario),
                      const SizedBox(
                        width: 14.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${auxUser!.nombreUsuario} ${auxUser!.apellidoUsuario}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            auxUser!.correoUsuario,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Cerrar sesión'),
                  onTap: () {
                    alerta(context);
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  void alerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              '¡Alerta!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: const Text(
            '¡¡Estas Intentando Cerrar Sesión!!\n¿Estas seguro de que deseas cerrar sesión?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'homePage', (Route<dynamic> route) => false);
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
