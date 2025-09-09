import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providetask/post/post.dart';
import 'package:providetask/task_provider.dart';
import 'package:providetask/ui/auth/login_screen.dart';

class SplashService {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      // Get user data from Firebase Database
      try {
        final uid = user.uid;
        final userRef = FirebaseDatabase.instance.ref("Users").child(uid);
        final snapshot = await userRef.get();

        if (snapshot.exists) {
          final userData = snapshot.value as Map<dynamic, dynamic>;
          final username = userData['username'] ?? '';
          final email = userData['email'] ?? '';

          // Set user data in TaskProvider
          final taskProvider = Provider.of<TaskProvider>(
            context,
            listen: false,
          );
          taskProvider.setUser(username, email);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }

      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const postscreen()),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        ),
      );
    }
  }
}
