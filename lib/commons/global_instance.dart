import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GlobalInstance {
  static late Box appDB;

  static Color primaryColor = Colors.purple;
  static Color secondaryColor = Colors.purpleAccent;

  static initDB() async {
    appDB = await Hive.openBox(
      'iTravelDB',
      path: kIsWeb ? null : (await getApplicationDocumentsDirectory()).path,
    );
  }
}
