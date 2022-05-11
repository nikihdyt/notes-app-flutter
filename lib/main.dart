import 'package:flutter/material.dart';
import 'package:note_app/database.dart';
import 'Note.dart';
import 'screen/NewNoteScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      home: MyHomePage(title: 'Note App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<List<Note>> notes; // variabel daftar catatan
  var dbHelper;

  @override
  void initState() {
    super.initState();

    // buat instance class DBHelper dari database.dart
    dbHelper = DBHelper();

    loadNotes();
  }

  // memanggil/load catatannya
  loadNotes() {
    // letakkan fungsi di dalam setState karena mereka akan mengubah state/UI nya
    setState(() {
      // beri nilai untuk notes (yg dipanggil di UI)
      notes = dbHelper.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
      ),
      // data yang muncul di UI datangnya di Future, jadi pakai widget FutureBuilder
      body: FutureBuilder(
          // data yg diambil di future -> var notes
          future: notes,
          builder: (context, AsyncSnapshot snapshot) { // snapshot: panggilan dari data-data di daftar catatan
            if (snapshot.hasData) {
              // success
              if (snapshot.data!.length == 0)
                return Center(child: Text('still empty'));

              return Container(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final currentItem = snapshot.data![index];
                      return ListTile(title: Text('${currentItem.title}'));
                    },
                  ));
            } else if (snapshot.hasError) {
              // error
              return Center(
                child: Text('error fetching notes'),
              );
            } else {
              // loading
              return CircularProgressIndicator();
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewNoteScreen())
          );
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }
}
