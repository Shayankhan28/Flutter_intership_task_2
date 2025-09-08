import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetaskss/post/post.dart';
import 'package:firebasetaskss/ui/auth/signup_screen.dart';
import 'package:firebasetaskss/util/utills.dart';
import 'package:firebasetaskss/wigdetss/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    _auth
        .signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        )
        .then((value) {
          Utills().toastermessage("Sucessfully Login");
          Navigator.push(
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
