import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../app/themes/app_colors.dart';
import 'time_picker.dart';

class CustomDateTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime selectedDate) onDateTimeSelected;
  final String title;

  const CustomDateTimePicker({
    super.key,
    this.initialDate,
    required this.onDateTimeSelected,
    this.title = "Select a Date",
  });

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    widget.onDateTimeSelected(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              // controller: _datePickerController,
              backgroundColor: AppColors.lightGrey,
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: AppColors.lightGrey,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),
              selectionMode: DateRangePickerSelectionMode.single,
              view: DateRangePickerView.month,
              onSelectionChanged: _onSelectionChanged,
              monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: Theme.of(context).textTheme.bodySmall,
                disabledDatesTextStyle: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.disabledColor),
                textStyle: Theme.of(context).textTheme.bodySmall,
              ),
              rangeTextStyle: Theme.of(context).textTheme.bodySmall,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionColor: AppColors.primaryColor,
              startRangeSelectionColor: AppColors.primaryColor,
              endRangeSelectionColor: AppColors.primaryColor,
              // rangeSelectionColor: AppColors.lightCalendar,
              selectionRadius: 8,
              minDate: DateTime.now(),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.transparent),
                      child: Center(child: Text('Cancel')),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_selectedDate != null) {
                        context.pop();
                        final TimeOfDay? pickedTime = await showAppTimePicker(
                          context: context,
                        );
                        if (pickedTime != null) {
                          final DateTime finalDateTime = DateTime(
                            _selectedDate!.year,
                            _selectedDate!.month,
                            _selectedDate!.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          widget.onDateTimeSelected(finalDateTime);
                        }
                      }
                    },
                    child: const Text("Select Time"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = args.value;
  }
}
