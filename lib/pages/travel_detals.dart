import 'package:flutter/material.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/share_travel.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../commons/global_instance.dart';
import 'home.dart';

class TravelDetailsPage extends StatefulWidget {
  final TravelModel travel;

  const TravelDetailsPage({
    required this.travel,
    super.key,
  });

  @override
  State<TravelDetailsPage> createState() => _TravelDetailsPageState();
}

class _TravelDetailsPageState extends State<TravelDetailsPage> {
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
                  builder: (context) => ShareTravel(widget.travel),
                ),
              );
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text(
                (widget.travel.travelTitle ?? "").toUpperCase(),
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Dal ${widget.travel.travelStartDate} al ${widget.travel.travelEndDate} (${widget.travel.travelDaysNumber}gg)",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              FixedTimeline.tileBuilder(
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
                  itemCount: widget.travel.travelDays.length,
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
                          FixedTimeline.tileBuilder(
                            theme: TimelineTheme.of(context).copyWith(
                              nodePosition: 0,
                              color: Colors.orange,
                            ),
                            builder: TimelineTileBuilder.connected(
                              connectionDirection: ConnectionDirection.before,
                              indicatorBuilder: (_, index) =>
                                  Indicator.outlined(borderWidth: 2),
                              connectorBuilder: (_, index, ___) =>
                                  Connector.solidLine(),
                              contentsBuilder: (_, indexP) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget
                                                    .travel
                                                    .travelDays[index]
                                                    .travelPoints[indexP]
                                                    .pointName ??
                                                "",
                                            style: const TextStyle(
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Text(
                                            widget
                                                    .travel
                                                    .travelDays[index]
                                                    .travelPoints[indexP]
                                                    .pointHour ??
                                                "",
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      widget
                                                  .travel
                                                  .travelDays[index]
                                                  .travelPoints[indexP]
                                                  .pointDescription !=
                                              null
                                          ? Text(
                                              widget
                                                  .travel
                                                  .travelDays[index]
                                                  .travelPoints[indexP]
                                                  .pointDescription!,
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                );
                              },
                              itemCount: widget
                                  .travel.travelDays[index].travelPoints.length,
                            ),
                          )
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
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InsertDaysPage(
                        editPoint: null,
                        travelDays: widget.travel.travelDaysNumber,
                        startDate: widget.travel.travelStartDate,
                        travelTitle: widget.travel.travelTitle ,
                        endDate: widget.travel.travelEndDate,
                      ),),),
                    },
                    child: const Text("Modfica itinerario"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      GlobalInstance.appDB.delete(widget.travel.travelTitle);
                      Navigator.popUntil(
                        context,
                        (route) => route.isFirst,
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    child: const Text("Elimina itinerario"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
