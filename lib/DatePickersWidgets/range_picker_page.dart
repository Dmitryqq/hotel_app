import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hotel_app/bloc/room_order_bloc.dart';
import 'package:hotel_app/event.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:hotel_app/model/room.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/screens/date_picker_screen.dart';
import 'package:provider/provider.dart';

class RangePickerPage extends StatefulWidget {
  final List<Event> events;

  const RangePickerPage({Key key, this.events}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RangePickerPageState();
}

class _RangePickerPageState extends State<RangePickerPage> {
  int difference;
  DateTime _firstDate;
  DateTime _lastDate;
  DatePeriod _selectedPeriod;

  Color selectedPeriodStartColor;
  Color selectedPeriodLastColor;
  Color selectedPeriodMiddleColor;

  RoomsOrderBloc _roomsOrderBloc;

  double price = 0;

  @override
  void initState() {
    super.initState();

    _firstDate = DateTime.now();
    _lastDate = DateTime.now().add(Duration(days: 45));

    DateTime selectedPeriodStart = DateTime.now().add(Duration(minutes: 10));
    DateTime selectedPeriodEnd =
        DateTime.now().add(Duration(days: 1, minutes: 10));
    _selectedPeriod = DatePeriod(selectedPeriodStart, selectedPeriodEnd);
    difference = _selectedPeriod.end.difference(_selectedPeriod.start).inDays;
    selectedPeriodStartColor = Colors.lightGreen;
    selectedPeriodMiddleColor = Colors.orangeAccent;
    selectedPeriodLastColor = Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    // add selected colors to default settings
    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: selectedPeriodLastColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: selectedPeriodStartColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
    );

    return Consumer<RoomsOrderBloc>(builder: (context, _roomsOrderBloc, child) {
      this._roomsOrderBloc = _roomsOrderBloc;
      return StreamBuilder<RoomOrder>(
          stream: _roomsOrderBloc.getRoomOrder,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.data.datePeriod != null) {
                _selectedPeriod = snapshot.data.datePeriod;
                price = snapshot.data.room.price;
              }
            }
//            print("${_selectedPeriod.end}  ${_selectedPeriod.start}");
            difference =
                _selectedPeriod.end.difference(_selectedPeriod.start).inDays;
            return Flex(
                direction:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? Axis.vertical
                        : Axis.horizontal,
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Center(
                          child: RangePicker(
                        selectedPeriod: _selectedPeriod,
                        onChanged: _onSelectedDateChanged,
                        firstDate: _firstDate,
                        lastDate: _lastDate,
                        datePickerStyles: styles,
                        eventDecorationBuilder: _eventDecorationBuilder,
                      ))),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                difference == 1
                                    ? "$difference day"
                                    : "$difference days",
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              if (price != 0)
                                Text(
                                  "${price} \$ per day",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                ),
                              if (price != 0)
                                Text(
                                  "${difference * price} \$ total",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),
                                )
                            ],
                          )))
                ]);
          });
    });
  }

  void _onSelectedDateChanged(DatePeriod newPeriod) {
    bool check = true;
    for (final event in events) {
      if (newPeriod.end.isAfter(event.date)) {
        check = false;
        break;
      }
    }
    setState(() {
//      print("${newPeriod.end.day}  ${_selectedPeriod.start.day}");
      if (check) {
        _selectedPeriod = newPeriod.end.day == _selectedPeriod.start.day
            ? DatePeriod(DateTime.now().add(Duration(minutes: 10)),
                DateTime.now().add(Duration(days: 1, minutes: 10)))
            : DatePeriod(
                DateTime.now().add(Duration(minutes: 10)), newPeriod.end);
//        print("123");
        _roomsOrderBloc.setOrder.add(_selectedPeriod);
      }
    });
  }

  EventDecoration _eventDecorationBuilder(DateTime date) {
    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    BoxDecoration roundedBorder = BoxDecoration(
        border: Border.all(color: Colors.red, width: 6),
        borderRadius: BorderRadius.all(Radius.circular(3.0)));

    return isEventDate ? EventDecoration(boxDecoration: roundedBorder) : null;
  }
}
