import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:itravel/models/travel_day.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/widgets/appbar.dart';
import 'package:itravel/pages/widgets/day_timeline.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../models/travel_point.dart';
import 'insert_day_details.dart';

class InsertDaysPage extends StatefulWidget {
  final int travelDays;
  final String startDate, endDate, travelTitle;
  const InsertDaysPage({
    super.key,
    required this.travelDays,
    required this.startDate,
    required this.travelTitle,
    required this.endDate,
  });

  @override
  State<InsertDaysPage> createState() => _InsertDaysPageState();
}

class _InsertDaysPageState extends State<InsertDaysPage> {
  Map<int, List<TravelPoint>> points = {};

  @override
  void initState() {
    for (int d = 0; d < widget.travelDays; d++) {
      points[d + 1] = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppAppbar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                "Giorni totali: ${widget.travelDays}\n\nDal ${widget.startDate} al ${widget.endDate}",
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0,
                    color: Colors.orange,
                    indicatorTheme: const IndicatorThemeData(
                      position: 0,
                      size: 20,
                    ),
                    connectorTheme: const ConnectorThemeData(
                      thickness: 2.5,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: widget.travelDays,
                    contentsBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Giorno ${index + 1}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DayTimeline(
                              points: points[index + 1] ?? [],
                              dayNumber: index + 1,
                              onTapAdd: () async {
                                TravelPoint? tp = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const InsertDayDetailsPage(),
                                  ),
                                );

                                if(tp != null){
                                  points[index + 1]?.add(tp);
                                } 
                                setState(() {});
                                return (tp != null);
                              },
                              onTapRem: (int i) {
                                setState(() {
                                  points[index + 1]?.removeAt(i);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    indicatorBuilder: (_, index) {
                      return const DotIndicator();
                    },
                    connectorBuilder: (_, index, ___) => Connector.solidLine(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(points);

                  TravelDay(
                    dayDate: null,
                    dayTitle: "Giorno",
                    travelPoints: [],
                  );

                  TravelModel(
                    travelTitle: widget.travelTitle,
                    travelStartDate: widget.startDate,
                    travelEndDate: widget.endDate,
                    travelCode: null,
                    travelDaysNumber: widget.travelDays,
                    travelDays: [],
                  );
                },
                child: const Text("Salva Itinerario"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
