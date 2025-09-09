import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:providetask/post/post.dart';
import 'package:providetask/task_provider.dart';
import 'package:providetask/ui/auth/signup_screen.dart';
import 'package:providetask/util/utills.dart';
import 'package:providetask/wigdetss/buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool laoding = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      laoding = true;
    });

    _auth
        .signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        )
        .then((value) async {
          // Get user data from Firebase Database
          final uid = value.user!.uid;
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

          Utills().toastermessage("Successfully Login");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => postscreen()),
          );
          setState(() {
            laoding = false;
          });
        })
        .onError((error, stackTrace) {
          Utills().toastermessage(error.toString());
          setState(() {
            laoding = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    textfileddss(
                      text_of_textfield: "Email",
                      type: TextInputType.emailAddress,
                      controller: emailcontroller,
                      iconss: const Icon(Icons.email),
                      vali: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }

                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9])*@[a-zA-Z0-9]+([.-]?[a-zA-Z0-9])*\.[a-zA-Z]{2,}$',
                        );

                        if (!emailRegex.hasMatch(value)) {
                          return "Enter a valid email";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    Password(
                      controller: passwordcontroller,
                      vali: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                  ],
                ),
              ),
              buttonss(
                loading: laoding,
                texttile: "Login",
                textcolor: Colors.white,
                fontwight: FontWeight.w500,
                buttoncolor: Colors.deepPurpleAccent,
                outlinecolor: const Color.fromARGB(255, 233, 227, 235),
                callback: () {
                  if (_formkey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              RichText(
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Signup",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
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
    );
  }
}
