import 'package:flutter/material.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';
import 'package:proyecto_recetario/pantallas/agregarReceta.dart';
import 'package:proyecto_recetario/pantallas/editarReceta.dart';
import 'package:proyecto_recetario/widgets/drawerMenu.dart';

class RecetasUsuario extends StatefulWidget {
  final dynamic id;

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
    _cargarRecetas();
  }

  Future<void> _cargarRecetas() async {
    _recetas = await RecetaBasesDeDatos.readAllReceta();
    setState(() {
      _recetasFiltradas = _recetas;
    });
  }

  void _busquedaCategoria(String query) {
    final recetasFiltradas = _recetas.where((receta) {
      final recetaCategoria = receta.categoriaReceta.toLowerCase();
      final input = query.toLowerCase();

      return recetaCategoria.contains(input);
    }).toList();

    setState(() {
      _recetasFiltradas = recetasFiltradas;
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // barra de busqueda
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
            // ver lista de las recetas
            ListView.builder(
              shrinkWrap: true,
              itemCount: _recetasFiltradas.length,
              itemBuilder: (context, index) {
                final receta = _recetasFiltradas[index];
                return ListTile(
                  title: Text(receta.nombreReceta),
                  subtitle: Text(receta.descripcionReceta),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditarReceta(receta: receta),
                      ),
                    );
                  },
                );
              },
            ),
            // boton de agregar receta
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgregaRreceta()),
                      );
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                      padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 12, vertical: 7)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
