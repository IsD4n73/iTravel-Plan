import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itravel/commons/global_instance.dart';
import 'package:itravel/pages/insert_shared.dart';
import 'package:itravel/pages/insert_travel.dart';
import 'package:itravel/pages/travel_detals.dart';
import 'package:itravel/pages/widgets/curved_list_item.dart';

import '../models/travel_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TravelModel> travels = [];

  @override
  void initState() {
    for (String key in GlobalInstance.appDB.keys) {
      setState(() {
        travels.add(
          TravelModel.fromJson(
            jsonDecode(
              GlobalInstance.appDB.get(key),
            ),
          ),
        );
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("iTravel"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InsertSharedTravel(),
                ),
              );
            },
            icon: const Icon(Icons.add_link),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InsertTravelPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: travels.isEmpty
          ? const Center(
              child: Text(
              "Non sono stati trovati itinerari\n😔",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ))
          : SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: travels.length,
                itemBuilder: (context, index) {
                  Color colorOne = GlobalInstance.primaryColor;
                  Color colorTwo = GlobalInstance.secondaryColor;

                  if (travels.length == 1) {
                    colorTwo = GlobalInstance.primaryColor;
                  }

                  if (index % 2 != 0) {
                    colorOne = GlobalInstance.secondaryColor;
                    colorTwo = GlobalInstance.primaryColor;
                  }

                  if (index == travels.length - 1) {
                    colorTwo = const Color(0xff202020);
                  }

                  return CurvedListItem(
                    title: travels[index].travelTitle ?? "",
                    days: travels[index].travelDaysNumber ?? 0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TravelDetailsPage(travel: travels[index]),
                        ),
                      );
                    },
                    color: colorOne,
                    nextColor: colorTwo,
                  );
                },
              ),
            ),
    );
  }
}
