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
          return receta.categoriaReceta
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'TastyRecipes',
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: buscadorController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Buscar categoría de la Receta...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  onChanged: (value) {
                    _busquedaCategoria(value);
                  },
                ),
              ),
              _recetasFiltradas.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _recetasFiltradas.length,
                      itemBuilder: (context, index) {
                        final receta = _recetasFiltradas[index];
                        return Container(
                            color: Colors.white,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        VerReceta(receta: receta),
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Imagen de la receta
                                    SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Image.file(
                                        File(receta.fotoReceta),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Nombre de la receta centrado
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          receta.nombreReceta,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Descripción de la receta
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        receta.descripcionReceta,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    // Categoría de la receta
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        'Categoría: ${receta.categoriaReceta}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    // Botón de editar
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            bool? result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarReceta(
                                                        receta: receta),
                                              ),
                                            );
                                            if (result != null && result) {
                                              _cargarTodasRecetas(); // Recargar recetas al volver
                                            }
                                          },
                                          child: Icon(Icons.edit,
                                              color: Colors.white),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.black)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    )
                  : const Center(
                      child: Text('No hay recetas disponibles'),
                    ),
            ],
          ),
        ),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
