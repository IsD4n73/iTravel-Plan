import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';

class StartEndDatePicker extends StatefulWidget {
  final void Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;

  const StartEndDatePicker({super.key, required this.onSelectionChanged});

  @override
  State<StartEndDatePicker> createState() => _StartEndDatePickerState();
}

class _StartEndDatePickerState extends State<StartEndDatePicker> {
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text("Seleziona la data di partenza e arrivo:"),
        const SizedBox(height: 5),
        SfDateRangePicker(
          controller: _controller,
          showActionButtons: false,
          showNavigationArrow: true,
          toggleDaySelection: true,
          selectionMode: DateRangePickerSelectionMode.range,
          onSelectionChanged: widget.onSelectionChanged,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
