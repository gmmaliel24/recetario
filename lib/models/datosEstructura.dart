class Receta {
  final int? idReceta;
  final String nombreReceta;
  final String descripcionReceta;
  final String fotoReceta;
  final String procedimientoReceta;
  final List<String> ingredientesReceta;
  final int tiempoReceta;
  final String categoriaReceta;
  final int? idUsuario;

  Receta({
    this.idReceta,
    required this.nombreReceta,
    required this.descripcionReceta,
    required this.fotoReceta,
    required this.procedimientoReceta,
    required this.ingredientesReceta,
    required this.tiempoReceta,
    required this.categoriaReceta,
    required this.idUsuario,
  });

  Receta copy({
    int? idReceta,
    String? nombreReceta,
    String? descripcionReceta,
    String? fotoReceta,
    List<String>? ingredientesReceta,
    String? procedimientoReceta,
    int? tiempoReceta,
    String? categoriaReceta,
    int? idUsuario,
  }) {
    return Receta(
      idReceta: idReceta ?? this.idReceta,
      nombreReceta: nombreReceta ?? this.nombreReceta,
      descripcionReceta: descripcionReceta ?? this.descripcionReceta,
      fotoReceta: fotoReceta ?? this.fotoReceta,
      ingredientesReceta: ingredientesReceta ?? this.ingredientesReceta,
      procedimientoReceta: procedimientoReceta ?? this.procedimientoReceta,
      tiempoReceta: tiempoReceta ?? this.tiempoReceta,
      categoriaReceta: categoriaReceta ?? this.categoriaReceta,
      idUsuario: idUsuario ?? this.idUsuario,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idReceta': idReceta,
      'nameReceta': nombreReceta,
      'descripcionReceta': descripcionReceta,
      'pathFotoReceta': fotoReceta,
      'procedimientoReceta': procedimientoReceta,
      'ingredientesReceta': ingredientesReceta.join(','),
      'tiempoReceta': tiempoReceta,
      'categoriaReceta': categoriaReceta,
      'idUsuario': idUsuario,
    };
  }

  factory Receta.fromMap(Map<String, dynamic> map) {
    return Receta(
      idReceta: map['idReceta'],
      nombreReceta: map['nameReceta'],
      descripcionReceta: map['descripcionReceta'],
      fotoReceta: map['pathFotoReceta'],
      procedimientoReceta: map['procedimientoReceta'],
      ingredientesReceta:
          List<String>.from(map['ingredientesReceta'].split(',')),
      tiempoReceta: map['tiempoReceta'],
      categoriaReceta: map['categoriaReceta'],
      idUsuario: map['idUsuario'],
    );
  }
}

class Usuario {
  final int? idUsuario;
  final String nombreUsuario;
  final String apellidoUsuario;
  final String correoUsuario;
  final String contraseniaUsuario;
  final String fotoUsuario;

  Usuario({
    this.idUsuario,
    required this.nombreUsuario,
    required this.apellidoUsuario,
    required this.correoUsuario,
    required this.contraseniaUsuario,
    required this.fotoUsuario,
  });

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nombreUsuario': nombreUsuario,
      'apellidoUsuario': apellidoUsuario,
      'correoUsuario': correoUsuario,
      'contraseniaUsuario': contraseniaUsuario,
      'fotoUsuario': fotoUsuario,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'],
      nombreUsuario: map['nombreUsuario'],
      apellidoUsuario: map['apellidoUsuario'],
      correoUsuario: map['correoUsuario'],
      contraseniaUsuario: map['contraseniaUsuario'],
      fotoUsuario: map['fotoUsuario'],
    );
  }
}
