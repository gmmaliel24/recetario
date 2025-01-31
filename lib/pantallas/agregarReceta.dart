// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AgregaRreceta extends StatefulWidget {
  final dynamic idUsuario;

  AgregaRreceta({super.key, required this.idUsuario});

  @override
  _AgregaRrecetaState createState() => _AgregaRrecetaState();
}

class _AgregaRrecetaState extends State<AgregaRreceta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerNombreReceta = TextEditingController();
  final TextEditingController _controllerDescripcionReceta =
      TextEditingController();
  final TextEditingController _controllerIngredientesReceta =
      TextEditingController();
  final TextEditingController _controllerInstruccionesReceta =
      TextEditingController();
  final TextEditingController _controllerTiempoReceta = TextEditingController();
  File? _imageReceta;

  final List<String> items = [
    'Desayuno',
    'Almuerzo',
    'Cena',
    'Postre',
    'Refacción',
    'Bebida Fría',
    'Bebida Caliente',
  ];
  String? selectedValued;

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
      String tiempoReceta = _controllerTiempoReceta.text;
      String? categoriaReceta = selectedValued;
      File? imagen = _imageReceta;

      if (nombreReceta.isEmpty ||
          descripcionReceta.isEmpty ||
          ingredientesReceta.isEmpty ||
          instruccionesReceta.isEmpty ||
          tiempoReceta == 0 ||
          imagen == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor llene todos los campos')));
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
          tiempoReceta: int.parse(tiempoReceta),
          categoriaReceta: categoriaReceta,
          estado: 1,
          idUsuario: widget.idUsuario,
        );

        await RecetaBasesDeDatos.inserReceta(receta);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Receta Guardada Con Éxito"),
          ),
        );

        Navigator.of(context).pop(true);
      }
    } catch (e) {
      print('error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al Guardar la Receta'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Agregar Receta',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _guardarReceta,
            child: Row(
              children: [
                const Text(
                  'Guardar  ',
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
                backgroundColor: WidgetStateProperty.all(Colors.white)),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
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
                  padding: EdgeInsets.all(10.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar Categoria',
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      value: selectedValued,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValued = value;
                        });
                      },
                    ),
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _controllerCategoriaReceta,
                    decoration: const InputDecoration(
                        labelText:
                            'Categoria de la receta\n(Desayuno, Almuerzo, Cena, Postre, Otros.)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor ingrese la categoría';
                      }
                      return null;
                    },
                  ),
                ),*/
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
                        labelText:
                            'Ingrese el tiempo de preparacion (minutos)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por Favor ingrese el tiempo de preparacion en minutos';
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
                const SizedBox(height: 16.0),
                _imageReceta == null
                    ? const Center(
                        child: Text(
                        'No se ha seleccionado ninguna imagen.',
                        style: TextStyle(fontSize: 16),
                      ))
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
