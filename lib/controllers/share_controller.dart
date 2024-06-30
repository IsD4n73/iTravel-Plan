import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bot_toast/bot_toast.dart';
import 'package:itravel/commons/app_urls.dart';
import 'package:itravel/models/travel_model.dart';

class ShareController {
  static Future<String?> getShareCode(TravelModel travel) async {
    var resp = await http.post(
      Uri.parse(AppUrls.shareTravelUrl),
      headers: {
        "App-Name": "iTravel_App",
      },
      body: jsonEncode(travel.toJson()),
    );

    if (resp.statusCode != 200) {
      BotToast.showText(
          text: "Non è stato possibile condividere l'itinerario, riprova");
      return null;
    }

    var body = jsonDecode(resp.body);
    return body["code"];
  }

  static Future<TravelModel?> getSharedTravel(String code) async {
    var resp = await http.get(
      Uri.parse("${AppUrls.getSaredTravelUrl}?code=$code"),
      headers: {
        "App-Name": "iTravel_App",
      },
    );

    if (resp.statusCode != 200) {
      BotToast.showText(
          text: "Non è stato possibile recuperare l'itinerario, riprova");
      return null;
    }

    var body = TravelModel.fromJson(jsonDecode(resp.body));
    body.travelCode = code;
    return body;
  }
}
