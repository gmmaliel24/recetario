import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';

class EditarReceta extends StatefulWidget {
  final Receta receta;

  EditarReceta({required this.receta});

  @override
  _EditarRecetaState createState() => _EditarRecetaState();
}

class _EditarRecetaState extends State<EditarReceta> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controllerNombreReceta;
  late TextEditingController _controllerDescripcionReceta;
  late TextEditingController _controllerIngredientesReceta;
  late TextEditingController _controllerInstruccionesReceta;
  late TextEditingController _controllerTiempoReceta;
  late TextEditingController _controllerCategoriaReceta;
  File? _imageReceta;

  @override
  void initState() {
    super.initState();
    _controllerNombreReceta = TextEditingController(text: widget.receta.nombreReceta);
    _controllerDescripcionReceta = TextEditingController(text: widget.receta.descripcionReceta);
    _controllerIngredientesReceta = TextEditingController(text: widget.receta.ingredientesReceta.join(', '));
    _controllerInstruccionesReceta = TextEditingController(text: widget.receta.procedimientoReceta);
    _controllerTiempoReceta = TextEditingController(text: widget.receta.tiempoReceta.toString());
    _controllerCategoriaReceta = TextEditingController(text: widget.receta.categoriaReceta);
    _imageReceta = File(widget.receta.fotoReceta);
  }

  Future<void> pickImage({required bool fromCamera}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: fromCamera ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imageReceta = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al seleccionar la imagen')));
    }
  }

  void _editarReceta() async {
    try {
      String nombreReceta = _controllerNombreReceta.text;
      String descripcionReceta = _controllerDescripcionReceta.text;
      String ingredientesReceta = _controllerIngredientesReceta.text;
      String instruccionesReceta = _controllerInstruccionesReceta.text;
      String tiempoReceta = _controllerTiempoReceta.text;
      String categoriaReceta = _controllerCategoriaReceta.text;
      File? imagen = _imageReceta;

      if (nombreReceta.isEmpty ||
          descripcionReceta.isEmpty ||
          ingredientesReceta.isEmpty ||
          instruccionesReceta.isEmpty ||
          tiempoReceta.isEmpty ||
          imagen == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor llene todos los campos')));
        return;
      }

      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
      final localImage = await imagen.copy('$path/$imageName');
      
      final receta = Receta(
        idReceta: widget.receta.idReceta,
        nombreReceta: nombreReceta,
        descripcionReceta: descripcionReceta,
        fotoReceta: localImage.path,
        procedimientoReceta: instruccionesReceta,
        ingredientesReceta: ingredientesReceta.split(',').map((e) => e.trim()).toList(),
        tiempoReceta: int.parse(tiempoReceta),
        categoriaReceta: categoriaReceta,
      );

      await RecetaBasesDeDatos.updateReceta(receta);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Receta Guardada Con Éxito")));
      Navigator.of(context).pop(); // Close the edit screen
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al Guardar la Receta')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Editar Receta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _editarReceta,
            child: const Row(
              children: [
                Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.save,
                  color: Colors.black,
                )
              ],
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
          ),
          SizedBox(width: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerNombreReceta,
                    decoration:
                        const InputDecoration(labelText: 'Nombre de la Receta'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerDescripcionReceta,
                    decoration: const InputDecoration(
                        labelText: 'Descripción de la receta'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la descripción de la receta';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerIngredientesReceta,
                    decoration: const InputDecoration(
                        labelText: 'Ingredientes (separados por coma)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor ingrese los ingredientes';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerInstruccionesReceta,
                    decoration: const InputDecoration(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerTiempoReceta,
                    decoration: const InputDecoration(
                        labelText: 'Ingrese el tiempo de preparación (minutos)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor ingrese el tiempo de preparación en minutos';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => pickImage(fromCamera: true),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    ElevatedButton(
                      onPressed: () => pickImage(fromCamera: false),
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                _imageReceta == null
                    ? const Center(
                        child: Text('No se ha seleccionado ninguna imagen.', style: TextStyle(fontSize: 16),))
                    : Image.file(_imageReceta!),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
