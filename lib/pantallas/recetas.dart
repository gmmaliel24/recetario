import 'package:flutter/material.dart';

class RecetasUsuario extends StatefulWidget{
  @override
  _RecetasUsuario createState() => _RecetasUsuario();

}

class _RecetasUsuario extends State<RecetasUsuario>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('recetas Usuario'),),
    );
  }

}