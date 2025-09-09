import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasetask/post/add_post.dart';
import 'package:firebasetask/ui/auth/login_screen.dart';
import 'package:firebasetask/util/utills.dart';
import 'package:flutter/material.dart';

class postscreen extends StatefulWidget {
  const postscreen({super.key});

  @override
  State<postscreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<postscreen> {
  final _auth = FirebaseAuth.instance;
  String username = "";
  String email = "";
  TextEditingController taskController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String searchKeyword = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final uid = _auth.currentUser!.uid;
    final userRef = FirebaseDatabase.instance.ref("Users").child(uid);

    userRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          username = data["username"] ?? "Guest User";
          email = data["email"] ?? _auth.currentUser?.email ?? "";
        });
      } else {
        setState(() {
          username = "Guest User";
          email = _auth.currentUser?.email ?? "";
        });
      }
    });
  }

  // 🔴 delete task from Firebase
  void _deleteTask(String key) {
    final uid = _auth.currentUser!.uid;
    final ref = FirebaseDatabase.instance.ref("UserData").child(uid).child(key);

    ref
        .remove()
        .then((_) {
          Utills().toastermessage("Task deleted ❌");
        })
        .onError((error, stackTrace) {
          Utills().toastermessage("Error: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    final uid = _auth.currentUser!.uid;
    final refs = FirebaseDatabase.instance.ref("UserData").child(uid);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                accountName: Text(
                  username.isNotEmpty ? username : "Guest User",
                ),
                accountEmail: Text(
                  email.isNotEmpty ? email : _auth.currentUser?.email ?? "",
                ),
                decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
              ),
              ListTile(
                leading: const Icon(Icons.logout_outlined, color: Colors.red),
                title: const Text("Logout"),
                onTap: () {
                  _auth
                      .signOut()
                      .then((value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      })
                      .onError((error, stackTrace) {
                        Utills().toastermessage(error.toString());
                      });
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text("My Tasks"),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                children: [
                  // 🔎 Search box
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
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),

                  // 📋 Task List
                  Expanded(
                    child: FirebaseAnimatedList(
                      query: refs,
                      itemBuilder: (context, snapshot, animation, index) {
                        final task =
                            snapshot.child("Task").value?.toString() ?? "";
                        final key = snapshot.key ?? "";

                        if (searchKeyword.isNotEmpty &&
                            !task.toLowerCase().contains(searchKeyword)) {
                          return const SizedBox.shrink(); // hide if not match
                        }

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(task),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteTask(key),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AddPost(controller: taskController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
