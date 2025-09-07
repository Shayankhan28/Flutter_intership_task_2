import 'package:apitask/Routings/routename.dart';
import 'package:apitask/screen/homescreen.dart';
import 'package:apitask/screen/profilescreen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateroute(RouteSettings settings) {
    switch (settings.name) {
      case Routename.homescreen:
        return MaterialPageRoute(builder: (context) => Homescreen());

      case Routename.profilescreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => Profilescreen(
            image: args["image"],
            firstname: args["firstname"],
            lastname: args["lastname"],
            email: args["email"],
          ),
        );

      default:
        throw Exception("Page not found");
    }
  }
}
