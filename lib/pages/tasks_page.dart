import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController taskNameController = TextEditingController();
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy HH:mm');

  void openTaskBox({String? id, String? initialName, bool? initialIsCompleted}) {
    taskNameController.text = initialName ?? '';
    bool isCompleted = initialIsCompleted ?? false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(hintText: "Task Name"),
            ),
            CheckboxListTile(
              title: const Text("Completed"),
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value ?? false;
                });
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (id == null) {
                firestoreService.addTask(taskNameController.text, isCompleted);
              } else {
                firestoreService.updateTask(id, taskNameController.text, isCompleted);
              }
              taskNameController.clear();
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
      appBar: AppBar(title: const Text("Tasks")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTaskBox(),
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var name = doc['name'];
              var isCompleted = doc['isCompleted'] as bool;
              var timestamp = (doc['timestamp'] as Timestamp).toDate();

              return ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(dateFormat.format(timestamp), style: const TextStyle(color: Colors.grey)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => openTaskBox(id: doc.id, initialName: name, initialIsCompleted: isCompleted),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => firestoreService.deleteTask(doc.id),
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