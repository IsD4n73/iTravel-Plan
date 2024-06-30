import 'package:flutter/material.dart';
import 'package:itravel/pages/insert_travel.dart';
import 'package:itravel/pages/widgets/appbar.dart';
import 'package:itravel/pages/widgets/curved_list_item.dart';

import '../models/travel_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TravelModel> travels = [];

  int testVar = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
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
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CurvedListItem(
              title: "title",
              days: 2,
              onTap: () {},
              color: Colors.orange,
              nextColor: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}
