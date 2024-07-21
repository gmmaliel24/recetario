import 'package:flutter/material.dart';
import 'package:proyecto_recetario/database/db.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';
import 'package:proyecto_recetario/pantallas/agregarReceta.dart';
import 'package:proyecto_recetario/widgets/drawerMenu.dart';

class RecetasUsuario extends StatefulWidget {
  final dynamic id;

  const RecetasUsuario({super.key, required this.id});

  @override
  _RecetasUsuario createState() => _RecetasUsuario();
}

class _RecetasUsuario extends State<RecetasUsuario> {
  final d
n
  TextEditingController buscadorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
  }

  Future<void> _busquedaCategoria(String query) async {
    //final filtrarElementos
    dynamic recetas = await RecetaBasesDeDatos.readAllReceta();
    setState(() {
          
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
                  )),
              // ver lista de las recetas
              ListView.builder(itemBuilder: (context, index){
                
              },),
              // boton de busqueda
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgregaRreceta()));
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black),
                          padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                              horizontal: 12, vertical: 7))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
