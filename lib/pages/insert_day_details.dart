import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:itravel/commons/global_instance.dart';
import 'package:itravel/pages/widgets/appbar.dart';

import '../models/travel_point.dart';

class InsertDayDetailsPage extends StatefulWidget {
  const InsertDayDetailsPage({super.key});

  @override
  State<InsertDayDetailsPage> createState() => _InsertDayDetailsPageState();
}

class _InsertDayDetailsPageState extends State<InsertDayDetailsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TimeOfDay? timeTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Aggiungi le informazioni per la tappa"),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: "Tappa",
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descController,
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: "Descrizione",
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DateTime dt = DateTime.now();
                  TimeOfDay tod = TimeOfDay(hour: dt.hour, minute: dt.minute);

                  timeTap = await showTimePicker(
                    context: context,
                    initialTime: tod,
                  );
                  setState(() {});
                },
                child: Text(
                    "Seleziona un orario ${timeTap != null ? "(${timeTap!.hour}:${timeTap!.minute})" : ""}"),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      TravelPoint(
                        pointName: nameController.text.trim(),
                        pointHour: timeTap != null
                            ? "${timeTap!.hour} : ${timeTap!.minute}"
                            : null,
                        pointDescription: descController.text.isEmpty
                            ? null
                            : descController.text,
                      ),
                    );
                  } else {
                    BotToast.showText(
                        text: "Il nome della tappe è obbligatorio");
                  }
                },
                child: const Text("Aggiungi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
