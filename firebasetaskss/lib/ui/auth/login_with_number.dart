import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetaskss/ui/auth/login_screen.dart';
import 'package:firebasetaskss/ui/auth/signup_screen.dart';
import 'package:firebasetaskss/ui/auth/verifyauthcode.dart';
import 'package:firebasetaskss/util/utills.dart';
import 'package:firebasetaskss/wigdetss/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginWithNumber extends StatefulWidget {
  const LoginWithNumber({super.key});

  @override
  State<LoginWithNumber> createState() => _LoginWithNumberState();
}

class _LoginWithNumberState extends State<LoginWithNumber> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController phonecontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool laoding = false;

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      laoding = true;
    });
    _auth.verifyPhoneNumber(
      phoneNumber: phonecontroller.text,
      verificationCompleted: (_) {
        setState(() {
          laoding = false;
        });
      },
      verificationFailed: (e) {
        setState(() {
          laoding = false;
        });
        Utills().toastermessage(e.toString());
      },
      codeSent: (String verification_id, int? token) {
        Utills().toastermessage("Code sent");

        setState(() {
          laoding = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Verifyauthcode(verification_id: verification_id),
          ),
        );
      },
      codeAutoRetrievalTimeout: (e) {
        Utills().toastermessage(e.toString());
        setState(() {
          laoding = false;
        });
      },
    );
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
                      text_of_textfield: "Phone",
                      type: TextInputType.phone,

                      controller: phonecontroller,
                      iconss: const Icon(Icons.phone_android_outlined),
                      vali: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter phone number";
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  child: Text(
                    "Login with Email",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
