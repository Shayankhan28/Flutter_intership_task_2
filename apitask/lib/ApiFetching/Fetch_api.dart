import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:apitask/models/model.dart';

Future<Model> getapidata() async {
  try {
    final String response = await rootBundle.loadString(
      'assets/json/users.json',
    );
    var data = jsonDecode(response);
    return Model.fromJson(data);
  } catch (e) {
    throw Exception("No data found!");
  }
}
