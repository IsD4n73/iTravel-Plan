import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:itravel/controllers/share_controller.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/home.dart';
import 'package:itravel/pages/widgets/appbar.dart';

import '../commons/global_instance.dart';

class InsertSharedTravel extends StatefulWidget {
  const InsertSharedTravel({super.key});

  @override
  State<InsertSharedTravel> createState() => _InsertSharedTravelState();
}

class _InsertSharedTravelState extends State<InsertSharedTravel> {
  TextEditingController controller = TextEditingController();
  TravelModel? travel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Text("Inserisci il codice dell'itinerario"),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                hintStyle: const TextStyle(color: Colors.black),
                hintText: "Codice",
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isEmpty) {
                  BotToast.showText(text: "Il codice inserito non è valido");
                  return;
                }
                var canc = BotToast.showLoading();

                TravelModel? tr = await ShareController.getSharedTravel(
                    controller.text.trim());

                if (tr == null) {
                  BotToast.showText(text: "L'itinerario non è stato trovato");
                  canc();
                  return;
                }

                setState(() {
                  travel = tr;
                });

                canc();
              },
              child: const Text("Cerca itinerario"),
            ),
            const SizedBox(height: 25),
            travel == null ? const SizedBox.shrink() : const Divider(),
            travel == null
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        (travel!.travelTitle ?? "").toUpperCase(),
                        style: TextStyle(
                          color: GlobalInstance.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          "Dal ${travel!.travelStartDate} al ${travel!.travelEndDate}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (GlobalInstance.appDB
                              .containsKey(travel!.travelTitle)) {
                            GlobalInstance.appDB.delete(travel!.travelTitle);
                          }

                          await GlobalInstance.appDB.put(travel!.travelTitle,
                              jsonEncode(travel!.toJson()));

                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        },
                        child: const Text("Salva itinerario"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
