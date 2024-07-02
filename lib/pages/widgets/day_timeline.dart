import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import '../../commons/global_instance.dart';
import '../../models/travel_point.dart';

class DayTimeline extends StatefulWidget {
  final List<TravelPoint> points;
  final int dayNumber;
  final Future<bool> Function() onTapAdd;
  final Future<bool> Function(TravelPoint trvl, int ind) onTapEdit;
  final void Function(int i) onTapRem;
  final int? editDayStep;

  const DayTimeline({
    required this.points,
    required this.dayNumber,
    required this.onTapAdd,
    required this.onTapEdit,
    required this.onTapRem,
    this.editDayStep,
    super.key,
  });

  @override
  State<DayTimeline> createState() => _DayTimelineState();
}

class _DayTimelineState extends State<DayTimeline> {
  int dayStep = 0;

  @override
  void initState() {
    setState(() {
      dayStep = widget.editDayStep ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineTheme.of(context).copyWith(
        nodePosition: 0,
        color: GlobalInstance.primaryColor,
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
                  if (await widget.onTapAdd()) {
                    setState(() {
                      dayStep++;
                    });
                  }
                },
                child: Text(
                  "+ Aggiungi Tappa",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: GlobalInstance.primaryColor,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () {
                widget.onTapEdit(widget.points[index], index);
              },
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
            ),
          );
        },
        itemExtentBuilder: (_, index) => 30,
        itemCount: dayStep + 1,
      ),
    );
  }
}
