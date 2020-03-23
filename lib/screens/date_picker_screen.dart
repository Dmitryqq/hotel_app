import 'package:flutter/material.dart';
import 'package:hotel_app/model/event.dart';
import 'package:hotel_app/DatePickersWidgets/range_picker_page.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: RangePickerPage(
        events: events,
      ),
    )));
  }
}

final List<Event> events = [
//  Event(DateTime.now().subtract(Duration(days: 3)), "Ev1"),
//  Event(DateTime.now().subtract(Duration(days: 13)), "Ev2"),
//  Event(DateTime.now().subtract(Duration(days: 30)), "Ev3"),
  Event(DateTime.now().add(Duration(days: 3)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 4)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 5)), "Ev4"),
  Event(DateTime.now().add(Duration(days: 13)), "Ev5"),
  Event(DateTime.now().add(Duration(days: 30)), "Ev6"),
];
