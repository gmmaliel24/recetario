import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                      height: 450,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage('https://img.freepik.com/foto-gratis/vista-superior-sabrosos-rollos-berenjena-papas-al-horno-condimentos-oscuridad_140725-104451.jpg?w=740&t=st=1721330084~exp=1721330684~hmac=81daeff05d46f4cbf132d39e07ddb28fef3dd7d2829eb9bfb267490433f5b0de'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network('https://img.freepik.com/foto-gratis/vista-superior-sabrosos-rollos-berenjena-papas-al-horno-condimentos-oscuridad_140725-104451.jpg?w=740&t=st=1721330084~exp=1721330684~hmac=81daeff05d46f4cbf132d39e07ddb28fef3dd7d2829eb9bfb267490433f5b0de', fit: BoxFit.cover,)
                      
                    ),      
            ],
          ),
        ),
      ),
    );
  }
}
