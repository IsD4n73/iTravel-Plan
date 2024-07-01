class TravelPoint {
  TravelPoint({
    required this.pointName,
    required this.pointHour,
    required this.pointDescription,
  });

  final String? pointName;
  final String? pointHour;
  final String? pointDescription;

  factory TravelPoint.fromJson(Map<String, dynamic> json) {
    return TravelPoint(
      pointName: json["pointName"],
      pointHour: json["pointHour"],
      pointDescription: json["pointDescription"],
    );
  }

  Map<String, dynamic> toJson() => {
        "pointName": pointName,
        "pointHour": pointHour,
        "pointDescription": pointDescription,
      };

  @override
  String toString() {
    return "$pointName, $pointHour, $pointDescription, ";
  }
}
