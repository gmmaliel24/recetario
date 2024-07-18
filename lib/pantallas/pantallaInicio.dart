import 'package:flutter/material.dart';
import 'package:proyecto_recetario/pantallas/inicio_sesion.dart';
import 'package:proyecto_recetario/pantallas/registro.dart';

class Pantallainicio extends StatelessWidget {
  const Pantallainicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu, color: Colors.white,),
              SizedBox(width: 10,),
              Text('TastyRecipe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,),
              ),
            ],
          )
        ),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 450,
                width: double.infinity,
                child: Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fclaudiascatering%2F&psig=AOvVaw02H5tiCBPUteRi0G9llnWc&ust=1721416463734000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLCr7JqmsYcDFQAAAAAdAAAAABAR', fit: BoxFit.cover,)
              ),
              const SizedBox(height: 30),
              const Text('Guarda Tus Recetas Favoritas',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              const SizedBox(height: 15,),
              const Padding(
                padding: EdgeInsets.all(25.0),
                child: Text('Bienvenido, con nuestra aplicación TastyRecipe podrás guardar tus recetas favoritas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),),
              ),
              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InicioSesion(),),);
              },
              child: Text('Iniciar Sesión',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.black, width: 2)),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 100, vertical: 15),),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                
                ),
                
              ),
              ),
              const SizedBox(height: 34,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Registro(),),);
              },
              child: Text('Registrarse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
  
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black),
                side: WidgetStateProperty.all(const BorderSide(color: Colors.white, width: 2)),
                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 110, vertical: 15)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                
                ),
                
              ),
              ),
            ],
          ),
          bottomSheet: Container(
            color: Colors.black,
            height: 50,
            child: const Center(
              child: Text('TastyRecipe 2024',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              ),
            ),
          )
    );
  }
}
