import 'package:apitask/Routings/routename.dart';
import 'package:apitask/Routings/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routename.homescreen,
      onGenerateRoute: Routes.generateroute,
    );
  }
}
