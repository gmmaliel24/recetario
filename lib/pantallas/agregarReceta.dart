import 'dart:io';
import 'package:flutter/material.dart';

class AgregaRreceta extends StatefulWidget {
  @override
  _AgregarRecetaState createState() => _AgregarRecetaState();
}

class _AgregarRecetaState extends State<AgregaRreceta> {
  final TextEditingController _controllerNombreReceta = TextEditingController();
  final TextEditingController _controllerDescripcionReceta =
      TextEditingController();
  final TextEditingController _controllerIngredientesReceta =
      TextEditingController();
  final TextEditingController _controllerInstruccionesReceta =
      TextEditingController();
  final TextEditingController _controllerTiempoReceta = TextEditingController();
  File? _imageReceta;

  void _guardarReceta() async {
    try {
      String nombreReceta = _controllerNombreReceta.text;
      String descripcionReceta = _controllerDescripcionReceta.text;
      String ingredientesReceta = _controllerIngredientesReceta.text;
      String instruccionesReceta = _controllerInstruccionesReceta.text;
      int tiempoReceta = _controllerTiempoReceta.text as int;
      File? imagen = _imageReceta;

      if (nombreReceta.isEmpty ||
          descripcionReceta.isEmpty ||
          ingredientesReceta.isEmpty ||
          instruccionesReceta.isEmpty ||
          tiempoReceta == 0 ||
          imagen == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor llene todos los campos')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al guardar toso')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: ElevatedButton(
            onPressed: () {
              Navigator.pop;
            },
            child: const Text(
              'Regresar',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
        title: const Center(
          child: Text(
            'Editar Receta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: _guardarReceta,
              child: const Row(
                children: [
                  Text(
                    'Guardar',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.save)
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Nombre de la Receta',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextField(
                controller: _controllerNombreReceta,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ingrese el nombre de la Receta',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
