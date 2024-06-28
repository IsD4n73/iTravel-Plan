import 'package:flutter/material.dart';
import 'package:itravel/pages/widgets/appbar.dart';

class INsertDaysPage extends StatefulWidget {
  final int travelDays;
  final String startDate, endDate;
  const INsertDaysPage({
    super.key,
    required this.travelDays,
    required this.startDate,
    required this.endDate,
  });

  @override
  State<INsertDaysPage> createState() => _INsertDaysPageState();
}

class _INsertDaysPageState extends State<INsertDaysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
