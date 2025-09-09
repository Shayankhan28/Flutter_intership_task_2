import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetask/util/utills.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  final TextEditingController controller;
  const AddPost({super.key, required this.controller});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _addTask() {
    if (widget.controller.text.trim().isEmpty) {
      Utills().toastermessage("Please enter a task");
      return;
    }

    setState(() => loading = true);

    final uid = _auth.currentUser!.uid;
    final databaseRef = FirebaseDatabase.instance.ref("UserData").child(uid);

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    databaseRef
        .child(id)
        .set({"Task": widget.controller.text.trim()})
        .then((value) {
          Utills().toastermessage("Task Added ✅");
          widget.controller.clear();
          setState(() => loading = false);
        })
        .onError((error, stackTrace) {
          Utills().toastermessage(error.toString());
          setState(() => loading = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input Field
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                hintText: "Add a new task",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Floating Button
        loading
            ? const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : FloatingActionButton(
                onPressed: _addTask,
                backgroundColor: Colors.deepPurpleAccent,
                child: const Icon(Icons.add, color: Colors.white),
              ),
      ],
    );
  }
}
