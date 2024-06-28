import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class GlobalInstance {
  static late Database appDB;

  static http.Client appClient = http.Client();

  static initDB() async {
    var document = await getApplicationDocumentsDirectory();
    File("${document.path}/iTravel.db").createSync();

    DatabaseFactory dbFactory = databaseFactoryIo;
    appDB =
        await dbFactory.openDatabase("${document.path}/KemonoDownloader.db");
  }
}
