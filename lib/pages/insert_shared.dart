import 'package:flutter/material.dart';
import 'package:itravel/pages/widgets/appbar.dart';

class InsertSharedTravel extends StatefulWidget {
  const InsertSharedTravel({super.key});

  @override
  State<InsertSharedTravel> createState() => _InsertSharedTravelState();
}

class _InsertSharedTravelState extends State<InsertSharedTravel> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: Column(
        children: [
          const Text("Inserisci il codice dell itinerario"),
          TextField(
            controller: controller,
          )
        ],
      ),
    );
  }
}
