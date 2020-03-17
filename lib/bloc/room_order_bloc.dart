import 'dart:async';
import 'package:hotel_app/model/room_order.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_app/model/visitor.dart';
import 'package:hotel_app/model/room.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class RoomsOrderBloc {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
//  Room _room;
//  Visitor _visitor;
//  DatePeriod _period;
  RoomOrder _roomOrder;

  RoomsOrderBloc() {
    _roomOrder = new RoomOrder();
    _roomOrder.room = new Room(0, "", 0, 0, 0, 0);
    _roomOrder.visitor = Visitor();
//    _roomOrder.datePeriod = new DatePeriod(DateTime.now().add(Duration(minutes: 5)), DateTime.now().add(Duration(minutes: 10)));
//    _visitor = null;
    _roomOrderController.stream.listen(_changeRoomOrder);
//    _roomOrderController.stream.listen(_changeDatePeriod);
//    _roomOrderController.stream.listen(_changeVisitor);
//    _roomOrderController.stream.listen(_changeDatePeriod);
//    _visitorController.stream.listen(_changeVisitor);
//    _datePeriodStream.stream.listen(_changeDatePeriod);
    _selectRoom.add(_roomOrder);
//    _selectDate.add(_roomOrder);
//    _selectVisitor.add(_roomOrder.visitor);
//    _selectDate.add(_period);
//    prefs.then((val) {
//      if (val.get('room_number') != null) {
//        _room_number = val.getInt('room_number') ?? -1;
//      } else {
//        _room_number = 1;
//      }
//    });
  }

  final _roomOrderStream = BehaviorSubject<RoomOrder>.seeded(null);
  Stream get getRoomOrder => _roomOrderStream.stream;
  Sink get _selectRoom => _roomOrderStream.sink;

//  final _roomStream = BehaviorSubject<Room>.seeded(null);
//  Stream get selectedRoom => _roomStream.stream;
//  Sink get _selectRoom => _roomStream.sink;
//
//  final _visitorStream = BehaviorSubject<Visitor>.seeded(null);
//  Stream get selectedVisitor => _visitorStream.stream;
//  Sink get _selectVisitor => _visitorStream.sink;

//  final _datePeriodStream = BehaviorSubject<DatePeriod>.seeded(null);
//  Stream get selectedDates => _datePeriodStream.stream;
//  Sink get _selectDate => _datePeriodStream.sink;

  StreamController _roomOrderController = StreamController();
  void get resetOrder => _roomOrderController.sink.add(null);
  StreamSink get setOrder => _roomOrderController.sink;
//  void get resetVisitor => _roomOrderController.sink.add(null);
//  StreamSink get setVisitor => _roomOrderController.sink;

//  StreamController _roomController = StreamController();
//  void get resetRoom => _roomController.sink.add(null);
//  StreamSink get selectRoom => _roomController.sink;
//
//  StreamController _visitorController = StreamController();
//  void get resetVisitor => _visitorController.sink.add(null);
//  StreamSink get setVisitor => _visitorController.sink;
//
//  StreamController _datePeriodController = StreamController();
//  void get resetPeriod => _datePeriodController.sink.add(null);
//  StreamSink get setPeriod => _datePeriodController.sink;

  void _changeRoomOrder(data) async {
//    print("roomdata: ${data is Visitor}");
    if (data is Room) {
      _roomOrder.room = data;
    } else if (data is Visitor){
      _roomOrder.visitor = data;
    } else if (data is DatePeriod){
      _roomOrder.datePeriod = data;
    }
//    _selectRoom.add(_roomOrder.room);
//    prefs.then((val) {
//      val.setInt('room_number', _room_number);
//    });
  }

  void _changeVisitor(data) async {
    if (data == null) {
      _roomOrder.visitor = null;
    } else {
      _roomOrder.visitor = data;
    }
//    _selectVisitor.add(_roomOrder.visitor);
  }

  void _changeDatePeriod(data) async {
//    print("data: ${data}");
    if (data == null) {
      _roomOrder.datePeriod = null;
    } else {
      _roomOrder.datePeriod = data;
    }
//    _selectDate.add(_period);
  }

  void dispose() {
    _roomOrderStream.close();
//    _roomStream.close();
//    _visitorStream.close();
//    _datePeriodStream.close();
    _roomOrderController.close();
//    _roomController.close();
//    _visitorController.close();
//    _datePeriodController.close();
  }
}
