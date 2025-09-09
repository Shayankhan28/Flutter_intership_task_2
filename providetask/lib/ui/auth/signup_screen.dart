import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providetask/post/post.dart';
import 'package:providetask/task_provider.dart';
import 'package:providetask/ui/auth/login_screen.dart';
import 'package:providetask/util/utills.dart';
import 'package:providetask/wigdetss/buttons.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signup() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
        .then((value) async {
          final uid = value.user!.uid; // ✅ user unique id
          final userRef = FirebaseDatabase.instance.ref("Users").child(uid);

          await userRef.set({
            "username": userController.text.trim(),
            "contact": phoneController.text.trim(),
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          });

          // Set user data in TaskProvider
          final taskProvider = Provider.of<TaskProvider>(
            context,
            listen: false,
          );
          taskProvider.setUser(
            userController.text.trim(),
            emailController.text.trim(),
          );

          setState(() {
            loading = false;
          });

          Utills().toastermessage("Sign Up Successful!");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const postscreen()),
          );

          // Clear fields
          userController.clear();
          phoneController.clear();
          emailController.clear();
          passwordController.clear();
        })
        .catchError((error) {
          Utills().toastermessage(error.toString());
          setState(() {
            loading = false;
          });
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  kToolbarHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      textfileddss(
                        text_of_textfield: "Username",
                        type: TextInputType.name,
                        controller: userController,
                        iconss: const Icon(Icons.person),
                        vali: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter username";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      textfileddss(
                        text_of_textfield: "Contact",
                        type: TextInputType.phone,
                        controller: phoneController,
                        iconss: const Icon(Icons.phone),
                        vali: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter contact";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      textfileddss(
                        text_of_textfield: "Email",
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        iconss: const Icon(Icons.email),
                        vali: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Password(
                        controller: passwordController,
                        vali: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      buttonss(
                        texttile: "Sign Up",
                        loading: loading,
                        textcolor: Colors.white,
                        fontwight: FontWeight.w500,
                        buttoncolor: Colors.deepPurpleAccent,
                        outlinecolor: const Color.fromARGB(255, 233, 227, 235),
                        callback: () {
                          if (formKey.currentState!.validate()) {
                            signup();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Login",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
