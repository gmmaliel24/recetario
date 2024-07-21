import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';

class AgregaRreceta extends StatefulWidget {
  @override
  _AgregarRecetaState createState() => _AgregarRecetaState();
}

class _AgregarRecetaState extends State<AgregaRreceta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombreReceta = TextEditingController();
  final TextEditingController _controllerDescripcionReceta =
      TextEditingController();
  final TextEditingController _controllerIngredientesReceta =
      TextEditingController();
  final TextEditingController _controllerInstruccionesReceta =
      TextEditingController();
  final TextEditingController _controllerTiempoReceta = TextEditingController();
  final TextEditingController _controllerCategoriaReceta =
      TextEditingController();
  File? _imageReceta;

  Future<void> pickImage({required bool fromCamarera}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          source: fromCamarera ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageReceta = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al seleccionar la imagen')));
    }
  }

  void _guardarReceta() async {
    try {
      String nombreReceta = _controllerNombreReceta.text;
      String descripcionReceta = _controllerDescripcionReceta.text;
      String ingredientesReceta = _controllerIngredientesReceta.text;
      String instruccionesReceta = _controllerInstruccionesReceta.text;
      int tiempoReceta = _controllerTiempoReceta.text as int;
      String categoriaReceta = _controllerCategoriaReceta.text;
      File? imagen = _imageReceta;

      if (nombreReceta.isEmpty ||
          descripcionReceta.isEmpty ||
          ingredientesReceta.isEmpty ||
          instruccionesReceta.isEmpty ||
          tiempoReceta == 0 ||
          imagen == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor llene todos los campos')));
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
        final localImage = await imagen.copy('$path/$imageName');
        final receta = Receta(
            nombreReceta: nombreReceta,
            descripcionReceta: descripcionReceta,
            fotoReceta: localImage.path,
            procedimientoReceta: instruccionesReceta,
            ingredientesReceta: ingredientesReceta.split(','),
            tiempoReceta: tiempoReceta,
            categoriaReceta: categoriaReceta);

        await RecetaBasesDeDatos.inserReceta(receta);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Receta Guardada Con Éxito"),
          ),
        );
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllerNombreReceta,
                  decoration: InputDecoration(labelText: 'Nombre de la Receta'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerIngredientesReceta,
                  decoration: InputDecoration(
                      labelText: 'Ingredientes (separados por coma)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese los ingredientes';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerInstruccionesReceta,
                  decoration: InputDecoration(
                      labelText:
                          'Ingrese las instrucciones para preparar la receta'),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese las instrucciones';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerTiempoReceta,
                  decoration: InputDecoration(
                      labelText: 'Ingrese el tiempo de preparacion (minutos)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por Favor ingrese los ingredientes';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => pickImage(fromCamarera: true),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () => pickImage(fromCamarera: false),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                _imageReceta == null
                    ? Center(
                        child: Text('No se ha seleccionado ninguna imagen.'))
                    : Image.file(_imageReceta!),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
