class Receta {
  final int? idReceta;
  final String nombreReceta;
  final String descripcionReceta;
  final String fotoReceta;
  final String procedimientoReceta;
  final List<String> ingredientesReceta;
  final int tiempoReceta;
  final String categoriaReceta;

  Receta({
    this.idReceta,
    required this.nombreReceta,
    required this.descripcionReceta,
    required this.fotoReceta,
    required this.procedimientoReceta,
    required this.ingredientesReceta,
    required this.tiempoReceta,
    required this.categoriaReceta,
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
      'categoriaReceta' : categoriaReceta,
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
          List<String>.from(map['ingredientesRecet'].split(',')),
      tiempoReceta: map['tiempoReceta'],
      categoriaReceta: map['categoriaReceta'],
    );
  }
  /*Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'imageProfile': imagePaht,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      username: map['username'],
      password: map['password'],
      imagePaht: map['imageProfile'],
    );
  }*/
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

/*
class Instrucciones {
  final int? idInstruccuiones;
  final String descripcionInstrucciones;
  final int numeroInstrucciones;

  Instrucciones({
    this.idInstruccuiones,
    required this.numeroInstrucciones,
    required this.descripcionInstrucciones,
  });

  Map<String, dynamic> toMap() {
    return {
      'idInstrucciones': idInstruccuiones,
      'numeroInstrucciones': numeroInstrucciones,
      'descripcionInstrucciones': descripcionInstrucciones,
    };
  }

  factory Instrucciones.fromMap(Map<String, dynamic> map) {
    return Instrucciones(
        idInstruccuiones: map['idInstrucciones'],
        numeroInstrucciones: map['numeroInstrucciones'],
        descripcionInstrucciones: map['descripcionInstrucciones']);
  }
}

class Ingredientes {
  final int? idIngrediente;
  final String nombreIngrediente;
  final int cantidadIngrediente;

  const Ingredientes(
      {this.idIngrediente,
      required this.nombreIngrediente,
      required this.cantidadIngrediente});

  Map<String, dynamic> toMap() {
    return {
      'idIngrediente': idIngrediente,
      'nombreIngrediente': nombreIngrediente,
      'cantidadIngrediente': cantidadIngrediente,
    };
  }

  factory Ingredientes.fromMap(Map<String, dynamic> map) {
    return Ingredientes(
        idIngrediente: map['idIgrediente'],
      nombreIngrediente: map['nombreIngrediente'],
      cantidadIngrediente: map['cantidadIngrediente'],
    );
  }
}

class Categoria {
  final int? idCategoria;
  final String nombreCategoria;
  final String descripcionCategoria;

  const Categoria({
    this.idCategoria,
    required this.nombreCategoria,
    required this.descripcionCategoria,
  });

  Map<String, dynamic> toMap() {
    return {
      'idCategoria': idCategoria,
      'nombreCategoria': nombreCategoria,
      'descripcionCategoria': descripcionCategoria,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      idCategoria: map['idCategoria'],
      nombreCategoria: map['nombreCategoria'],
      descripcionCategoria: map['descripcionCategoria'],
    );
  }
  */
