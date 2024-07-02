import 'package:intl/intl.dart';

class DateController {
  static List<DateTime> getDaysBeetween({
    required String? start,
    required String? end,
  }) {
    if (start == null || end == null) {
      return [];
    }

    DateTime startDate = DateFormat('dd/MMMM/yyyy').parse(start);
    DateTime endDate = DateFormat('dd/MMMM/yyyy').parse(end);

    final days = endDate.difference(startDate).inDays;

    return [
      for (int i = 0; i < days; i++)
        startDate.add(
          Duration(days: i),
        ),
    ];
  }
}
