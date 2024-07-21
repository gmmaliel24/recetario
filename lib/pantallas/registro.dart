import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';
import 'package:proyecto_recetario/pantallas/inicio_sesion.dart';
import 'package:proyecto_recetario/pantallas/recetas.dart';

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfirmPassword =
      TextEditingController();
  File? _image;
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void registroUsuario() async {
    try {
      String name = _controllerName.text;
      String lastName = _controllerLastName.text;
      String email = _controllerEmail.text;
      String password = _controllerPassword.text;
      String confirmPassword = _controllerConfirmPassword.text;
      File? image = _image;

      bool usuarioExistente =
          await RecetaBasesDeDatos.auntenticarUsuario(email, password);

      if (name.isEmpty ||
          lastName.isEmpty ||
          email.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty ||
          image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor llene todos los campos'),
          ),
        );
      } else if (password.length < 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La Cotraseña debe ser mayor a 8 caracteres'),
          ),
        );
      } else if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Las Contraseñas no Coinciden'),
          ),
        );
      } else if (usuarioExistente) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'El Correo o Usuario ya existe. ¡Por favor busqué otro Correo o Usuario!'),
          ),
        );
      } else {
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final imageName = '${DateTime.now().millisecondsSinceEpoch}.png';
        final localImage = await image.copy('$path/$imageName');
        final user = Usuario(
            nombreUsuario: name,
            apellidoUsuario: lastName,
            correoUsuario: email,
            contraseniaUsuario: password,
            fotoUsuario: localImage.path);

        await RecetaBasesDeDatos.insertUsuario(user);

        int idUsuarioRegistrado =
            await RecetaBasesDeDatos.idUser(email, password) as int;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario registrado correctamente'),
          ),
        );
        await Future.delayed(const Duration(seconds: 3));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecetasUsuario(
              id: idUsuarioRegistrado,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al registrar el usuario'),
      ));
    }
  }

  Future<void> pickImage({required bool fromCamarera}) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          source: fromCamarera ? ImageSource.camera : ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al seleccionar la imagen')));
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
          padding: const EdgeInsets.all(16),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Ingrese su Nombre: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controllerName,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Ingrese su Apellido: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controllerLastName,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.person_2_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Ingrese su Correo: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controllerEmail,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Ingrese su Contraseña: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controllerPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: IconButton(
                        icon: Icon(
                          _obscureText1
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                      )),
                  obscureText: _obscureText1,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Confirme su contraseña: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _controllerConfirmPassword,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: IconButton(
                        icon: Icon(
                          _obscureText2
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText2 = !_obscureText2;
                          });
                        },
                      )),
                  obscureText: _obscureText2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Ingrese su foto de perfil: ',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                    SizedBox(width: 16.0),
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
                _image == null
                    ? Center(
                        child: Text('No se ha seleccionado ninguna imagen.'))
                    : Image.file(_image!),
                SizedBox(height: 16.0),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿Ya tienes una cuenta?',
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InicioSesion(),
                        ),
                      );
                    },
                    child: const Text(
                      'Inicia Sesión',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  registroUsuario();
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 20, color: Colors.white),
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
