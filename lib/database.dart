import 'package:sqflite/sqflite.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'Note.dart';

class DBHelper {

  late Database _database;

  // menggunakan pola singleton -> hanya dapat dibuat instancenya sekali
  // me-return database yang dipakai di aplikasi ini
  Future<Database> get dbInstance async {
    if (_database != null) {
      return _database;
    } else{
      _database = await initDB();
      return _database;
    }
  }

  // membuat instance database
  initDB() async {
    // memanggil method openDatabase untuk mengkoneksikan database
    return await openDatabase(
      // menghubungkan path dan nama database yang akan dibentuk
        join(await getDatabasesPath(), 'notesapp.db'),
        // versi database sesuai perubahan databasenya
        version: 1,
        // membuat tabel saat pertama kali dieksekusi(onCreate)
        onCreate: (db, version) {
          return db.execute(
            // perintah SQL
              "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, body TEXT)"
          );
        }
    );
  }

  // me return daftar catatan yang sudah ada
  Future<List<Note>> getNotes() async {
    // mengambil referensi dari database
    final db = await dbInstance;

    // query daftar tabelnya, yg diambil dari nama tabel yg dibuat di initDB() -> onCreate
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // loop isi data di dalam daftar catatannya
    return List.generate(maps.length, (index) {
      // return dalam bentuk maps (maps: var yg dibuat diatas)
      return Note(id: maps[index]['id'],
          title: maps[index]['title'],
          body: maps[index]['body']);
    });
  }

}