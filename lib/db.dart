import 'package:censo_aplicacion/censo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  
  /*static late Database db;

  static Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE censo (id INTEGER PRIMARY KEY,nombre TEXT,correo TEXT,habitantes INTEGER,vacunados INTEGER,direccion TEXT,cp INTEGER)");
    });
  }*/

  static Future<Database> _openDB() async{
     return openDatabase(join(await getDatabasesPath(),'censo.db'),
      onCreate: (db,version){
        return db.execute(
          "CREATE TABLE censo (id INTEGER PRIMARY KEY,nombre TEXT,correo TEXT,habitantes INTEGER,vacunados INTEGER,direccion TEXT,cp INTEGER)"
        );
      },version: 1);
  }

  

  static void insert(Censo censo) async{
    Database database = await _openDB();
    database.insert("censo",censo.toMap());
  }

  static Future<List<Censo>> censos() async{
    Database database = await _openDB();

    final List<Map<String,dynamic>>censosMap = await database.query("censo");

    return List.generate(censosMap.length, (i) => Censo(
      censosMap[i]['nombre'],
      censosMap[i]['correo'],
      censosMap[i]['habitantes'],
      censosMap[i]['vacunados'],
      censosMap[i]['direccion'],
      censosMap[i]['cp']));
  }
  
}