import 'package:itravel/models/travel_point.dart';

class TravelDay {
  TravelDay({
    required this.dayDate,
    required this.dayTitle,
    required this.travelPoints,
  });

  final String? dayDate;
  final dynamic dayTitle;
  final List<TravelPoint> travelPoints;

  factory TravelDay.fromJson(Map<String, dynamic> json) {
    return TravelDay(
      dayDate: json["dayDate"],
      dayTitle: json["dayTitle"],
      travelPoints: json["TravelPoints"] == null
          ? []
          : List<TravelPoint>.from(
              json["TravelPoints"]!.map((x) => TravelPoint.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "dayDate": dayDate,
        "dayTitle": dayTitle,
        "TravelPoints": travelPoints.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$dayDate, $dayTitle, $travelPoints, ";
  }
}
