import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:itravel/commons/global_instance.dart';
import 'package:itravel/models/travel_day.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/home.dart';
import 'package:itravel/pages/widgets/appbar.dart';
import 'package:itravel/pages/widgets/day_timeline.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../models/travel_point.dart';
import 'insert_day_details.dart';

class InsertDaysPage extends StatefulWidget {
  final int travelDays;
  final String startDate, endDate, travelTitle;
  final Map<int, List<TravelPoint>>? editPoint;

  const InsertDaysPage({
    super.key,
    this.editPoint,
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
    if (widget.editPoint != null) {
      for (int d = 0; d < widget.editPoint!.length; d++) {
        points[d + 1] = widget.editPoint![d + 1]!;
      }
    } else {
      for (int d = 0; d < widget.travelDays; d++) {
        points[d + 1] = [];
      }
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
                              editDayStep: points[index + 1]?.length,
                              onTapAdd: () async {
                                TravelPoint? tp = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const InsertDayDetailsPage(),
                                  ),
                                );

                                if (tp != null) {
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
                onPressed: () async {
                  var canc = BotToast.showLoading();

                  if (widget.editPoint != null) {
                    GlobalInstance.appDB.delete(widget.travelTitle);
                  }

                  List<TravelDay> days = [];

                  points.forEach(
                    (key, value) {
                      days.add(
                        TravelDay(
                          dayDate: null,
                          dayTitle: "Giorno $key",
                          travelPoints: value,
                        ),
                      );
                    },
                  );

                  TravelModel travel = TravelModel(
                    travelTitle: widget.travelTitle,
                    travelStartDate: widget.startDate,
                    travelEndDate: widget.endDate,
                    travelCode: null,
                    travelDaysNumber: widget.travelDays,
                    travelDays: days,
                  );

                  await GlobalInstance.appDB
                      .put(travel.travelTitle, jsonEncode(travel.toJson()));
                  canc();

                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
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
