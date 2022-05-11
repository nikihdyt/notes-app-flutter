import 'package:flutter/material.dart';
import 'package:note_app/database.dart';
import 'package:note_app/Note.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {

  // agar bisa mengakses keseluruhan form dan memainkan validasinya
  final _noteForm = GlobalKey<FormState>(); // key dari Form
  // buat variabel controller
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  submitNote(context) {
    // jika keadaannya _noteForm sudah lolos validasi
    if (_noteForm.currentState!.validate()) {
      print('success');
      print('${titleController} - ${bodyController}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
      ),
      body: Container(
        padding: EdgeInsets.only(right: 20, top: 40, left: 20),
        child: Form(
          key: _noteForm, // untuk validasi form
          child: Column(
            children:  [

              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title', hintText: 'Your title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some title';
                  } else {
                    return null;
                  }
                },
              ),

              TextFormField(
                controller: bodyController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Body', hintText: 'Your body notes',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter notes';
                  } else {
                    return null;
                  }
                },
              ),

              ElevatedButton(
                onPressed: () => submitNote(context),
                child: Text('Save', style: TextStyle(fontSize: 20),),
                ),
            ],
          ),
        ),
      ),
    );
  }
  
}