import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GlobalInstance {
  static late Box appDB;

  static Color primaryColor = Colors.purple;
  static Color secondaryColor = Colors.purpleAccent;

  static initDB() async {
    var document = await getApplicationDocumentsDirectory();
    appDB = await Hive.openBox('iTravelDB', path: document.path);
  }
}
