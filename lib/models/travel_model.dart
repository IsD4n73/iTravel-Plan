import 'package:itravel/models/travel_day.dart';

/*
{
	"travelTitle": "",
        "travelText": "", 
	"travelStartDate": "",
	"travelEndDate": "",
	"travelDaysNumber": 2,
        "travelCode": null
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
    required this.travelCode,
    required this.travelDaysNumber,
    required this.travelDays,
    this.travelText = null, 
  });

  final String? travelTitle;
  final String? travelStartDate;
  final String? travelEndDate;
  final String? travelText;
  String? travelCode;
  final int? travelDaysNumber;
  final List<TravelDay> travelDays;

  factory TravelModel.fromJson(Map<String, dynamic> json) {
    return TravelModel(
      travelTitle: json["travelTitle"],
      travelStartDate: json["travelStartDate"],
      travelEndDate: json["travelEndDate"],
      travelCode: json["travelCode"],
      travelDaysNumber: json["travelDaysNumber"],
      travelText: json["travelText"], 
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
        "travelCode": travelCode,
        "travelDaysNumber": travelDaysNumber,
	"travelText": travelText, 
        "travelDays": travelDays.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$travelTitle, $travelStartDate, $travelEndDate, ";
  }
}
