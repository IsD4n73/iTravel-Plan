import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/widgets/appbar.dart';

class ShareTravel extends StatefulWidget {
  TravelModel travel;

  ShareTravel(this.travel, {super.key});

  @override
  State<ShareTravel> createState() => _ShareTravelState();
}

class _ShareTravelState extends State<ShareTravel> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.travel.travelCode == null) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: Center(
        child: InkWell(
          onTap: widget.travel.travelCode == null ? null : () {},
          child: Text(
            widget.travel.travelCode ?? "In generazione...",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
