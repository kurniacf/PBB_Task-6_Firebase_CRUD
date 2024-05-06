import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService firestoreService = FirestoreService();

  Widget buildRecentNotes() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getNotes().take(3),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var doc = snapshot.data!.docs[index];
            var title = doc['title'];
            var description = doc['description'];

            return ListTile(
              title: Text(title),
              subtitle: Text(description),
            );
          },
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

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var doc = snapshot.data!.docs[index];
            var name = doc['name'];
            var isCompleted = doc['isCompleted'] as bool;

            return ListTile(
              title: Text(name),
              subtitle: Text("Completed: $isCompleted"),
            );
          },
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
              child: Text(
                'Recent Notes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            buildRecentNotes(),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recent Tasks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            buildRecentTasks(),
          ],
        ),
      ),
    );
  }
}
