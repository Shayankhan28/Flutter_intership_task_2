import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providetask/post/add_post.dart';
import 'package:providetask/task_provider.dart';

class postscreen extends StatefulWidget {
  const postscreen({super.key});

  @override
  State<postscreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<postscreen> {
  TextEditingController taskController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String searchKeyword = "";

  @override
  void dispose() {
    taskController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  accountName: Text(
                    taskProvider.username.isNotEmpty
                        ? taskProvider.username
                        : "Guest User",
                    style: const TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    taskProvider.email.isNotEmpty ? taskProvider.email : "",
                    style: const TextStyle(color: Colors.white),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                final taskProvider = Provider.of<TaskProvider>(
                  context,
                  listen: false,
                );
                Navigator.of(context).pop(); // Close drawer first
                taskProvider.logout(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Box
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() => searchKeyword = value.toLowerCase());
                },
                decoration: InputDecoration(
                  hintText: "Search your tasks...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                ),
              ),
            ),

            // Task List
            Expanded(
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child) {
                  // Filter tasks based on search
                  final filteredTasks = taskProvider.tasks.where((task) {
                    if (searchKeyword.isEmpty) return true;
                    final taskText = task["task"]?.toLowerCase() ?? "";
                    return taskText.contains(searchKeyword);
                  }).toList();

                  if (filteredTasks.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            searchKeyword.isNotEmpty
                                ? Icons.search_off
                                : Icons.task_alt,
                            size: 100,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            searchKeyword.isNotEmpty
                                ? "No tasks found matching '$searchKeyword'"
                                : "No tasks yet. Add your first task!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index]["task"] ?? "";
                      final key = filteredTasks[index]["key"] ?? "";

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            task,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Show confirmation dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Task"),
                                    content: Text(
                                      "Are you sure you want to delete '$task'?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          taskProvider.deleteTask(key);
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Task deleted successfully!",
                                              ),
                                              backgroundColor: Colors.orange,
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Add Task Component at Bottom
            const SizedBox(height: 10),
            AddPost(controller: taskController),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
