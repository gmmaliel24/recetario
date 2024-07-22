import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto_recetario/models/datosEstructura.dart';

class RecetaBasesDeDatos {
  static Future<Database> initializadeDB() async {
    String path = join(await getDatabasesPath(), 'recetarioIntecap.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Usuario(idUsuario INTEGER NOT NULL CONSTRAINT PK_Usuario PRIMARY KEY AUTOINCREMENT, nombreUsuario TEXT, apellidoUsuario TEXT, correoUsuario TEXT, contraseniaUsuario TEXT, fotoUsuario TEXT);",
        );
        await db.execute(
          "CREATE TABLE Receta(idReceta INTEGER NOT NULL CONSTRAINT PK_Receta PRIMARY KEY AUTOINCREMENT, nameReceta TEXT, descripcionReceta TEXT, pathFotoReceta TEXT, procedimientoReceta TEXT, ingredientesReceta TEXT, tiempoReceta int, categoriaReceta TEXT, estado INTEGER, idUsuario INTEGER, CONSTRAINT Relationship5 FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario));",
        );
        await db
            .execute("CREATE INDEX IX_Relationship5 ON Receta (idUsuario);");
      },
      version: 1,
    );
  }

  /*Metodos de la tabla Usuarios*/

  static Future<int> insertUsuario(Usuario user) async {
    final Database db = await initializadeDB();
    return await db.insert('Usuario', user.toMap());
  }

  static Future<int> update(Usuario user) async {
    final Database db = await initializadeDB();
    return await db.update(
      'Usuario',
      user.toMap(),
      where: "idUsuario ?",
      whereArgs: [user.idUsuario],
    );
  }

  static Future<int?> idUser(String username, String password) async {
    final Database db = await initializadeDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Usuario',
      columns: ['idUsuario'],
      where: 'correoUsuario = ? AND contraseniaUsuario = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return maps.first['idUsuario'] as int?;
    } else {
      return null;
    }
  }

  static Future<Usuario?> readIdUser(int id) async {
    final Database db = await initializadeDB();
    final List<Map<String, dynamic>> result = await db.query(
      'Usuario',
      where: "idUsuario = ?",
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Usuario.fromMap(result.first);
    } else {
      return null;
    }
  }

  static Future<bool> auntenticarUsuario(
      String username, String password) async {
    final Database db = await initializadeDB();

    final List<Map<String, dynamic>> result = await db.query(
      'Usuario',
      where: "correoUsuario = ? AND contraseniaUsuario = ?",
      whereArgs: [username, password],
    );

    return result.isNotEmpty;
  }

  static Future<int> deleteUser(int id) async {
    final db = await initializadeDB();
    return await db.delete(
      'Usuario',
      where: "idUsuario = ?",
      whereArgs: [id],
    );
  }

  static Future<int> inserReceta(Receta receta) async {
    final Database db = await initializadeDB();
    return await db.insert('Receta', receta.toMap());
  }

  Future<Receta> createReceta(Receta receta) async {
    final db = await initializadeDB();
    final id = await db.insert('Receta', receta.toMap());
    return receta.copy(idReceta: id);
  }

  static Future<List<Receta>> readRecetasUsuario(int userId) async {
    final db = await initializadeDB();
    final maps = await db.query(
      'Receta',
      where: 'estado = 1 AND idUsuario = ?',
      whereArgs: [userId],
      orderBy: 'nameReceta ASC',
    );

    return maps.map((json) => Receta.fromMap(json)).toList();
  }

  static Future<Receta?> readReceta(int id) async {
    final db = await initializadeDB();
    final maps = await db.query(
      'Receta',
      columns: [
        'idReceta',
        'nameReceta',
        'descripcionReceta',
        'pathFotoReceta',
        'procedimientoReceta ',
        'ingredientesReceta',
        'tiempoReceta',
        'categoriaReceta',
      ],
      where: 'idReceta=?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Receta.fromMap(maps.first);
    } else {
      return null;
    }
  }

  //Todas las recetas
  static Future<List<Receta>> readAllReceta() async {
    final db = await initializadeDB();
    const orderBY = 'nameReceta ASC';
    final result = await db.query('Receta', orderBy: orderBY);
    return result.map((json) => Receta.fromMap(json)).toList();
  }

  //Actualizar Datos

  static Future<int> updateReceta(Receta receta) async {
    final db = await initializadeDB();
    return db.update(
      'Receta',
      receta.toMap(),
      where: 'idReceta =?',
      whereArgs: [receta.idReceta],
    );
  }

  //Borrar datos
  static Future<int> deleteReceta(Receta receta) async {
    final db = await initializadeDB();
    return db.update(
      'Receta',
      receta.toMap(),
      where: 'idReceta =?',
      whereArgs: [receta.idReceta],
    );
    //return await db.delete('Receta', where: 'idReceta = ?', whereArgs: [id]);
  }

  //Cerrar base de datos
  Future closeReceta() async {
    final db = await initializadeDB();
    db.close();
  }
}
