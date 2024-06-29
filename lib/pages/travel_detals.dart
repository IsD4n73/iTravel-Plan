import 'package:flutter/material.dart';
import 'package:itravel/pages/widgets/appbar.dart';

class TravelDetailsPage extends StatefulWidget {
  
  const INsertDaysPage({
    super.key, 
  });

  @override
  State<TravelDetailsPage> createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
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
