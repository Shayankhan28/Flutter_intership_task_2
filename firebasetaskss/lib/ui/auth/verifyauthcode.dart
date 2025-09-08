import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetaskss/post/post.dart';
import 'package:firebasetaskss/util/utills.dart';
import 'package:firebasetaskss/wigdetss/buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verifyauthcode extends StatefulWidget {
  final verification_id;
  const Verifyauthcode({super.key, required this.verification_id});

  @override
  State<Verifyauthcode> createState() => _VerifyauthcodeState();
}

class _VerifyauthcodeState extends State<Verifyauthcode> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController verifyphonecontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool laoding = false;

  @override
  void dispose() {
    verifyphonecontroller.dispose();
    super.dispose();
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
              "Verification",
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
                      text_of_textfield: "6 digits code",
                      type: TextInputType.phone,

                      controller: verifyphonecontroller,
                      // iconss: const Icon(Icons.verific),
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
                texttile: "Confirm",
                textcolor: Colors.white,
                fontwight: FontWeight.w500,
                buttoncolor: Colors.deepPurpleAccent,
                outlinecolor: const Color.fromARGB(255, 233, 227, 235),
                callback: () async {
                  setState(() {
                    laoding = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                    verificationId: widget.verification_id,
                    smsCode: verifyphonecontroller.text.toString(),
                  );
                  try {
                    await _auth.signInWithCredential(credential);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => postscreen()),
                    );
                  } catch (e) {
                    setState(() {
                      laoding = false;
                    });
                    Utills().toastermessage(e.toString());
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              RichText(
                text: TextSpan(
                  text: "Didn't Received a code? ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
