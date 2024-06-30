import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

class GlobalInstance {
  static late Box appDB;

  static bool needUpdate = false;

  static initDB() async {
    var document = await getApplicationDocumentsDirectory();
    appDB = await Hive.openBox('iTravelDB', path: document.path);
  }
}
