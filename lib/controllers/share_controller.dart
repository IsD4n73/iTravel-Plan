import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bot_toast/bot_toast.dart';
import 'package:itravel/commons/app_urls.dart';
import 'package:itravel/models/travel_model.dart';

class ShareController {
  static Future<String?> getShareCode(TravelModel travel) async {
    var respCode = await http.get(
      Uri.parse(AppUrls.getCodeUrl),
    );

    if (respCode.statusCode != 200) {
      BotToast.showText(
          text: "Non è stato possibile condividere l'itinerario, riprova");
      return null;
    }

    var body = jsonDecode(respCode.body);
    travel.travelCode = body["code"];

    var resp = await http.post(
      Uri.parse("${AppUrls.shareTravelUrl}?code=${body["code"]}"),
      headers: {
        "App-Name": "iTravel_App",
        "charset": "utf-8",
      },
      body: jsonEncode(travel.toJson()),
    );

    if (resp.statusCode != 200) {
      debugPrint("Status: ${resp.statusCode}");
      BotToast.showText(
          text: "Non è stato possibile condividere l'itinerario, riprova");
      return null;
    }

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
      debugPrint("Status: ${resp.statusCode}");
      BotToast.showText(
          text: "Non è stato possibile recuperare l'itinerario, riprova");
      return null;
    }

    var body = TravelModel.fromJson(jsonDecode(utf8.decode(resp.bodyBytes)));
    body.travelCode = code;
    return body;
  }
}
