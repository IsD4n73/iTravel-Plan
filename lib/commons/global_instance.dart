import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class GlobalInstance {
  static late Box appDB;

  static http.Client appClient = http.Client();

  static initDB() async {
    var document = await getApplicationDocumentsDirectory();
    appDB = await Hive.openBox('iTravelDB', path: document.path);
  }
}
