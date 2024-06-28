import 'package:itravel/models/travel_day.dart';

/*
{
	"travelTitle": "",
	"travelStartDate": "",
	"travelEndDate": "",
	"travelDays": [
		{
			"dayDate": "Cruise",
			"dayTitle": null,
			"TravelPoints": [
				{
					"pointName": "helloo",
					"pointHour": null,
					"pointDescription": "hhhhh"
				}
			]
		}
	]
}*/

class TravelModel {
  TravelModel({
    required this.travelTitle,
    required this.travelStartDate,
    required this.travelEndDate,
    required this.travelDays,
  });

  final String? travelTitle;
  final String? travelStartDate;
  final String? travelEndDate;
  final List<TravelDay> travelDays;

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      travelTitle: json["travelTitle"],
      travelStartDate: json["travelStartDate"],
      travelEndDate: json["travelEndDate"],
      travelDays: json["travelDays"] == null
          ? []
          : List<TravelDay>.from(
              json["travelDays"]!.map((x) => TravelDay.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "travelTitle": travelTitle,
        "travelStartDate": travelStartDate,
        "travelEndDate": travelEndDate,
        "travelDays": travelDays.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$travelTitle, $travelStartDate, $travelEndDate, $travelDays, ";
  }
}
