import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection reference for Notes and Tasks
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  // CREATE a new Note
  Future<void> addNote(String title, String description) {
    return notes.add({
      'title': title,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // READ all Notes
  Stream<QuerySnapshot> getNotes() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE a Note
  Future<void> updateNote(String id, String title, String description) {
    return notes.doc(id).update({
      'title': title,
      'description': description,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE a Note
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }

  // CREATE a new Task
  Future<void> addTask(String name, bool isCompleted) {
    return tasks.add({
      'name': name,
      'isCompleted': isCompleted,
      'timestamp': Timestamp.now(),
    });
  }

  // READ all Tasks
  Stream<QuerySnapshot> getTasks() {
    return tasks.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE a Task
  Future<void> updateTask(String id, String name, bool isCompleted) {
    return tasks.doc(id).update({
      'name': name,
      'isCompleted': isCompleted,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE a Task
  Future<void> deleteTask(String id) {
    return tasks.doc(id).delete();
  }
}
