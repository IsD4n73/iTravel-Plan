import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itravel/controllers/share_controller.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/widgets/appbar.dart';

import '../commons/global_instance.dart';

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
    if (widget.travel.travelCode == null) {
      ShareController.getShareCode(widget.travel).then(
        (value) {
          setState(() {
            widget.travel.travelCode = value;
          });
          GlobalInstance.appDB.delete(widget.travel.travelTitle);
          GlobalInstance.appDB.put(
            widget.travel.travelTitle,
            jsonEncode(
              widget.travel.toJson(),
            ),
          );
        },
      );
    }
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
