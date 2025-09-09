import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, String>> tasks = [];
  String username = "";
  String email = "";

  // Add a new task
  void addTask(String task) {
    if (task.isEmpty) return;
    tasks.add({
      "task": task,
      "key": DateTime.now().millisecondsSinceEpoch.toString(),
    });
    notifyListeners();
  }

  // Delete a task by key
  void deleteTask(String key) {
    tasks.removeWhere((task) => task["key"] == key);
    notifyListeners();
  }

  // Logout function
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Firebase logout
      username = "";
      email = "";
      tasks.clear();
      notifyListeners();

      // Navigate to login screen - Fixed navigation
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Logout failed: $e")));
    }
  }

  // Set user info after login
  void setUser(String name, String mail) {
    username = name;
    email = mail;
    notifyListeners();
  }
}
