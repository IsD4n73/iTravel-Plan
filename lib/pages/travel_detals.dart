import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:itravel/controllers/date_controller.dart';
import 'package:itravel/models/travel_model.dart';
import 'package:itravel/pages/share_travel.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:itravel/pages/insert_days.dart';
import 'package:itravel/models/travel_point.dart';
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
  late int todayIndex;

  @override
  void initState() {
    var days = DateController.getDaysBeetween(
      start: widget.travel.travelStartDate,
      end: widget.travel.travelEndDate,
    );

    DateTime today = DateTime.now();

    todayIndex = days.indexWhere(
      (element) =>
          element.day == today.day &&
          element.month == today.month &&
          element.year == today.year,
    );

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    (widget.travel.travelTitle ?? "").toUpperCase(),
                    style: TextStyle(
                      color: GlobalInstance.primaryColor,
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
                      color: GlobalInstance.primaryColor,
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Giorno ${index + 1}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  todayIndex == index
                                      ? Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                            color: GlobalInstance.primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            "OGGI",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: FixedTimeline.tileBuilder(
                                  theme: TimelineTheme.of(context).copyWith(
                                    nodePosition: 0,
                                    indicatorPosition: 0,
                                    color: GlobalInstance.primaryColor,
                                  ),
                                  builder: TimelineTileBuilder.connected(
                                    connectionDirection:
                                        ConnectionDirection.before,
                                    indicatorBuilder: (_, indexP) => widget
                                                .travel
                                                .travelDays[index]
                                                .travelPoints[indexP]
                                                .pointDescription ==
                                            null
                                        ? Indicator.outlined(
                                            borderWidth: 2,
                                          )
                                        : Indicator.dot(),
                                    connectorBuilder: (_, index, ___) =>
                                        Connector.solidLine(),
                                    contentsBuilder: (_, indexP) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 0, 8, 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: widget
                                                          .travel
                                                          .travelDays[index]
                                                          .travelPoints[indexP]
                                                          .pointDescription ==
                                                      null
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        widget
                                                                .travel
                                                                .travelDays[index]
                                                                .travelPoints[
                                                                    indexP]
                                                                .showDesc =
                                                            !widget
                                                                .travel
                                                                .travelDays[
                                                                    index]
                                                                .travelPoints[
                                                                    indexP]
                                                                .showDesc;
                                                      });
                                                    },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    ("${widget
                                                            .travel
                                                            .travelDays[index]
                                                            .travelPoints[
                                                                indexP]
                                                            .pointName} ${widget
                                                .travel
                                                .travelDays[index]
                                                .travelPoints[indexP]
                                                .pointDescription ==
                                            null ? "" : " +" }"),
                                                    style: TextStyle(
                                                      color: GlobalInstance
                                                          .primaryColor,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    (widget
                                                            .travel
                                                            .travelDays[index]
                                                            .travelPoints[
                                                                indexP]
                                                            .pointHour ??
                                                        ""),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            (widget
                                                            .travel
                                                            .travelDays[index]
                                                            .travelPoints[
                                                                indexP]
                                                            .pointDescription !=
                                                        null &&
                                                    widget
                                                        .travel
                                                        .travelDays[index]
                                                        .travelPoints[indexP]
                                                        .showDesc)
                                                ? Card(
                                                    color: GlobalInstance
                                                        .primaryColor
                                                        .withOpacity(0.7),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Text(
                                                        widget
                                                            .travel
                                                            .travelDays[index]
                                                            .travelPoints[
                                                                indexP]
                                                            .pointDescription!,
                                                        softWrap: true,
                                                        style: const TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: widget.travel.travelDays[index]
                                        .travelPoints.length,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      indicatorBuilder: (_, index) {
                        return const DotIndicator();
                      },
                      connectorBuilder: (_, index, ___) =>
                          Connector.solidLine(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: Border(
                        left: BorderSide(
                          color: GlobalInstance.primaryColor,
                          width: 8,
                        ),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              "Note",
                              style: TextStyle(
                                color: GlobalInstance.primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.travel.travelText ??
                                  "Nessuna nota presente",
                              softWrap: true,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Map<int, List<TravelPoint>> points = {};
                          for (int i = 0;
                              i < widget.travel.travelDays.length;
                              i++) {
                            points[i + 1] =
                                widget.travel.travelDays[i].travelPoints;
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InsertDaysPage(
                                editPoint: points,
                                notes: widget.travel.travelText,
                                travelDays: widget.travel.travelDaysNumber ?? 0,
                                startDate: widget.travel.travelStartDate ?? "",
                                travelTitle: widget.travel.travelTitle ?? "",
                                endDate: widget.travel.travelEndDate ?? "",
                              ),
                            ),
                          );
                        },
                        child: const Text("Modfica itinerario"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BotToast.showWidget(
                            toastBuilder: (cancelFunc) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "Vuoi eliminare l'itinerario?",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: GlobalInstance.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                            "ATTENZIONE: questa azione è irreversibile!"),
                                        const SizedBox(height: 30),
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    cancelFunc();
                                                  },
                                                  child: const Text("No"),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Expanded(
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    GlobalInstance.appDB.delete(
                                                        widget.travel
                                                            .travelTitle);
                                                    Navigator.popUntil(
                                                      context,
                                                      (route) => route.isFirst,
                                                    );
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomePage(),
                                                      ),
                                                    );
                                                    cancelFunc();
                                                  },
                                                  child: const Text("Si"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: const Text("Elimina itinerario"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
