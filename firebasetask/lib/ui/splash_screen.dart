import 'package:firebasetask/firebase_services/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() {
    SplashService().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(162, 131, 255, 234),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Lottie.asset(
                "assets/animations/Taskone.json",
                animate: true,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 100,
              width: 250,
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    "ToDo-List",
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                    duration: Duration(seconds: 4),
                  ),
                ],
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
