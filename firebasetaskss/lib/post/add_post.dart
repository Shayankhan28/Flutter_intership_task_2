import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetaskss/util/utills.dart';
import 'package:firebasetaskss/wigdetss/buttons.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Node2");
  TextEditingController emcontroller = TextEditingController();
  TextEditingController pscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add post")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: emcontroller,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "What is in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              controller: pscontroller,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: "Enter password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          buttonss(
            loading: loading,
            texttile: "Add",
            textcolor: Colors.white,
            fontwight: null,
            buttoncolor: Colors.deepPurpleAccent,
            outlinecolor: null,
            callback: () {
              setState(() {
                loading = true;
              });

              databaseRef
                  .child(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                    "Email": emcontroller.text.toString(),
                    "Password": pscontroller.text.toString(),
                    "ID": DateTime.now().millisecondsSinceEpoch.toString(),
                  })
                  .then((value) {
                    Utills().toastermessage("Post Added");
                    emcontroller.clear();
                    pscontroller.clear();
                    setState(() {
                      loading = false;
                    });
                  })
                  .onError((error, stackTrace) {
                    Utills().toastermessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
            },
          ),
        ],
      ),
    );
  }
}
