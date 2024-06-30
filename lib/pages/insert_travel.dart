import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:itravel/pages/insert_days.dart';
import 'package:itravel/pages/widgets/appbar.dart';
import 'package:itravel/pages/widgets/insert_date.dart';

class InsertTravelPage extends StatefulWidget {
  const InsertTravelPage({super.key});

  @override
  State<InsertTravelPage> createState() => _InsertTravelPageState();
}

class _InsertTravelPageState extends State<InsertTravelPage> {
  TextEditingController titleController = TextEditingController();
  String _startDate = "", _endDate = "";
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Text("Inserisci un nuovo viaggio"),
              const SizedBox(height: 50),
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.black),
                  hintText: "Titolo viaggio",
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              StartEndDatePicker(
                onSelectionChanged: (args) {
                  {
                    setState(() {
                      _startDate = DateFormat('dd/MMMM/yyyy')
                          .format(args.value.startDate)
                          .toString();
                      _endDate = DateFormat('dd/MMMM/yyyy')
                          .format(args.value.endDate ?? args.value.startDate)
                          .toString();
                    });
                  }
                },
              ),
              Text("Inizio: $_startDate\nFine: $_endDate"),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  onPressed: () {
                    if (_startDate == "" || _endDate == "") {
                      BotToast.showText(
                          text:
                              "Seleziona una data di inizio e una di fine per continuare");
                      return;
                    }
                    if (titleController.text.isEmpty) {
                      BotToast.showText(
                          text: "inserisci il titolo per continuare");
                      return;
                    }

                    var startDate =
                        DateFormat('dd/MMMM/yyyy').parse(_startDate);
                    var endDate = DateFormat('dd/MMMM/yyyy').parse(_endDate);

                    var travelDays = (endDate.difference(startDate).inDays) + 1;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InsertDaysPage(
                          travelDays: travelDays,
                          travelTitle: titleController.text,
                          startDate: _startDate,
                          endDate: _endDate,
                        ),
                      ),
                    );
                  },
                  child: const Text("Prosegui"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
