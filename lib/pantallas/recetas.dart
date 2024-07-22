import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';
import 'package:proyecto_recetario/pantallas/agregarReceta.dart';
import 'package:proyecto_recetario/pantallas/editarReceta.dart';
import 'package:proyecto_recetario/pantallas/verReceta.dart';
import 'package:proyecto_recetario/widgets/drawerMenu.dart';

class RecetasUsuario extends StatefulWidget {
  final int id;

  const RecetasUsuario({super.key, required this.id});

  @override
  _RecetasUsuario createState() => _RecetasUsuario();
}

class _RecetasUsuario extends State<RecetasUsuario> {
  TextEditingController buscadorController = TextEditingController();
  List<Receta> _recetas = [];
  List<Receta> _recetasFiltradas = [];

  @override
  void initState() {
    super.initState();
    _cargarTodasRecetas();
  }

  void _busquedaCategoria(String query) {
    setState(() {
      if (query.isEmpty) {
        _recetasFiltradas = _recetas;
      } else {
        _recetasFiltradas = _recetas.where((receta) {
          return receta.nombreReceta
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Future<void> _cargarTodasRecetas() async {
    try {
      final recetas = await RecetaBasesDeDatos.readRecetasUsuario(
        widget.id,
      );
      setState(() {
        _recetas = recetas;
        _recetasFiltradas = recetas;
      });
    } catch (e) {
      print('Esta es la excepción: $e');
    }
  }

  Image _convertirImagen(String imgString) {
    try {
      if (imgString.isNotEmpty) {
        return Image.file(
          File(imgString),
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
            'https://cdn.pixabay.com/photo/2021/11/24/05/19/user-6820232_960_720.png');
      }
    } catch (e) {
      return Image.memory(
        base64Decode(imgString),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'TastyRecipes ${widget.id}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: MenuUsuario(
        id: widget.id,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: buscadorController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Buscar categoría de la Receta...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintStyle: TextStyle(color: Colors.black),
              ),
              onChanged: (value) {
                _busquedaCategoria(value);
              },
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                padding: EdgeInsets.all(10),
                child: _recetasFiltradas.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: _recetasFiltradas.length,
                        itemBuilder: (context, index) {
                          final receta = _recetasFiltradas[index];
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(File(receta.fotoReceta)),
                              ),
                              title: Text(receta.nombreReceta),
                              subtitle: Text(receta.descripcionReceta),
                              trailing: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  bool? result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditarReceta(receta: receta),
                                    ),
                                  );
                                  if (result != null && result) {
                                    _cargarTodasRecetas(); // Recargar recetas al volver
                                  }
                                },
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerReceta(receta: receta),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('No hay recetas disponibles'),
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AgregaRreceta(
                idUsuario: widget.id,
              ),
            ),
          );
          if (result != null && result) {
            _cargarTodasRecetas(); // Recargar recetas al volver
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
