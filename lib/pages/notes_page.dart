import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  void openNoteBox({String? id, String? initialTitle, String? initialDescription}) {
    titleController.text = initialTitle ?? '';
    descriptionController.text = initialDescription ?? '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (id == null) {
                firestoreService.addNote(titleController.text, descriptionController.text);
              } else {
                firestoreService.updateNote(id, titleController.text, descriptionController.text);
              }
              titleController.clear();
              descriptionController.clear();
              Navigator.pop(context);
            },
            child: Text(id == null ? "Add" : "Update"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(),
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var title = doc['title'];
              var description = doc['description'];
              var timestamp = (doc['timestamp'] as Timestamp).toDate();

              return ListTile(
                title: Text(title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description),
                    Text(dateFormat.format(timestamp), style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => openNoteBox(id: doc.id, initialTitle: title, initialDescription: description),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => firestoreService.deleteNote(doc.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}