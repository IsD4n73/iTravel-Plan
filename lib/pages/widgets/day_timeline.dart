import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../models/travel_point.dart';

class DayTimeline extends StatefulWidget {
  final List<TravelPoint> points;
  final int dayNumber;
  final Future<bool> Function() onTapAdd;
  final void Function(int i) onTapRem;

  const DayTimeline({
    required this.points,
    required this.dayNumber,
    super.key,
    required this.onTapAdd,
    required this.onTapRem,
  });

  @override
  State<DayTimeline> createState() => _DayTimelineState();
}

class _DayTimelineState extends State<DayTimeline> {
  int dayStep = 0;

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineTheme.of(context).copyWith(
        nodePosition: 0,
        color: Colors.orange,
      ),
      builder: TimelineTileBuilder(
        indicatorBuilder: (_, index) => (index + 1 == dayStep + 1)
            ? Indicator.outlined(borderWidth: 2)
            : DotIndicator(
                child: InkWell(
                  onTap: () {
                    dayStep--;
                    widget.onTapRem(index);
                  },
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
              ),
        endConnectorBuilder: (_, index) =>
            (index + 1 == dayStep + 1) ? null : Connector.solidLine(),
        contentsBuilder: (_, index) {
          if (index + 1 == dayStep + 1) {
            return Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                onTap: () async {
                  
                  if(await widget.onTapAdd()){
                    setState(() {
                      dayStep++;
                    });
                  } 
                  
                },
                child: const Text(
                  "+ Aggiungi Tappa",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.points[index].pointName ?? "",
                ),
                Text(
                  widget.points[index].pointHour ?? "",
                ),
              ],
            ),
          );
        },
        itemExtentBuilder: (_, index) => 30,
        itemCount: dayStep + 1,
      ),
    );
  }
}
