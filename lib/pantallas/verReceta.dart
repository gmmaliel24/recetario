import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';

class VerReceta extends StatelessWidget {
  final Receta receta;

  const VerReceta({Key? key, required this.receta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          receta.nombreReceta,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (receta.fotoReceta.isNotEmpty)
                Image.file(
                  File(receta.fotoReceta),
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16.0),
              Text(
                receta.nombreReceta,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Descripción:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(receta.descripcionReceta),
              SizedBox(height: 8.0),
              Text(
                'Ingredientes:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(receta.ingredientesReceta.join(', ')),
              SizedBox(height: 8.0),
              Text(
                'Instrucciones:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(receta.procedimientoReceta),
              SizedBox(height: 8.0),
              Text(
                'Tiempo de preparación:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('${receta.tiempoReceta} minutos'),
              SizedBox(height: 8.0),
              Text(
                'Categoría:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(receta.categoriaReceta),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
