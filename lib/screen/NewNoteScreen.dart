import 'package:flutter/material.dart';
import 'package:note_app/database.dart';
import 'package:note_app/Note.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: Container(
        child: Column(
          children: const [
            TextField(
              decoration: InputDecoration(
                labelText: 'Judul', hintText: 'Isi judul',
              ),
            ),
            TextField(
              maxLines: 8,
              decoration: InputDecoration(
                labelText: 'Isi', hintText: 'Isi catatan',
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text('Save', style: TextStyle(fontSize: 20),),
              ),
          ],
        ),
      ),
    );
  }
  
}