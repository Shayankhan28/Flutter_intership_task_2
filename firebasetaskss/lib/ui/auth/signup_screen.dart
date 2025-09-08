import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetaskss/post/post.dart';
import 'package:firebasetaskss/ui/auth/login_screen.dart';
import 'package:firebasetaskss/util/utills.dart';
import 'package:firebasetaskss/wigdetss/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sigupdatasaved = FirebaseDatabase.instance.ref("SigupData");

  void signup() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
          email: emailController.text.trim().toString(),
          password: passwordController.text.trim().toString(),
        )
        .then((value) {
          setState(() {
            loading = false;
          });
          Utills().toastermessage("Sign Up Successful!");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => postscreen()),
          );
          setState(() {
            loading = false;
          });
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
                            return "Enter email";
                          }
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
                        },
                      ),
                      const SizedBox(height: 15),
                      Password(
                        controller: passwordController,
                        vali: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
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
                            _sigupdatasaved
                                .child(
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                )
                                .set({
                                  "ID": DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                                  "Username": userController.text
                                      .toString(), // put username first
                                  "Contact": phoneController.text.toString(),
                                  "Email": emailController.text.toString(),
                                })
                                .then((value) {
                                  Utills().toastermessage("Post Added");
                                  userController.clear();
                                  phoneController.clear();
                                  emailController.clear();
                                  passwordController.clear();
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
