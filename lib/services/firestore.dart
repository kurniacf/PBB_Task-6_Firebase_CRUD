import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection reference for Notes
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE a new Note
  Future<void> addNote(String note) {
    return notes.add({
      'note': note, 
      'timestamp': Timestamp.now()
    });
  }

  // READ get all Notes
  Stream<QuerySnapshot> getNotes() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  // UPDATE a Note
  Future<void> updateNote(String id, String note) {
    return notes.doc(id).update({
      'note': note,
      'timestamp': Timestamp.now()
    });
  }

  // DELETE a Note
  Future<void> deleteNote(String id) {
    return notes.doc(id).delete();
  }
}