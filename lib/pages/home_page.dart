import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  Widget buildRecentNotes() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotes().take(3),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            var title = doc['title'];
            var description = doc['description'];
            var timestamp = (doc['timestamp'] as Timestamp).toDate();

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 3,
              child: ListTile(
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(description),
                    Text(dateFormat.format(timestamp), style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                leading: const Icon(Icons.note, color: Colors.brown),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget buildRecentTasks() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks().take(3),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            var name = doc['name'];
            var isCompleted = doc['isCompleted'] as bool;
            var timestamp = (doc['timestamp'] as Timestamp).toDate();

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 3,
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(dateFormat.format(timestamp), style: const TextStyle(color: Colors.grey)),
                leading: const Icon(Icons.check, color: Colors.brown),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Recent Notes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            buildRecentNotes(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Recent Tasks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            buildRecentTasks(),
          ],
        ),
      ),
    );
  }
}