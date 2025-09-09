import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_provider.dart';

class AddPost extends StatefulWidget {
  final TextEditingController controller;
  const AddPost({super.key, required this.controller});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Row(
      children: [
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
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              onSubmitted: (value) {
                // Allow adding task by pressing Enter
                if (value.trim().isNotEmpty) {
                  _addTask(taskProvider);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        loading
            ? const SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : FloatingActionButton(
                onPressed: () => _addTask(taskProvider),
                backgroundColor: Colors.deepPurpleAccent,
                child: const Icon(Icons.add, color: Colors.white),
              ),
      ],
    );
  }

  void _addTask(TaskProvider taskProvider) {
    if (widget.controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a task"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => loading = true);

    // Add task to provider
    taskProvider.addTask(widget.controller.text.trim());

    // Clear the text field
    widget.controller.clear();

    // Hide loading state
    setState(() => loading = false);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task added successfully!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
