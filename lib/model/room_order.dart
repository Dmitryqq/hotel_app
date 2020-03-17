import 'package:flutter/cupertino.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:hotel_app/model/room.dart';
import 'package:hotel_app/model/visitor.dart';

class RoomOrder with ChangeNotifier{
  Room room;
  Visitor visitor;
  DatePeriod datePeriod;

  Room get getRoomState => room;
  set setRoomState(Room room){
    this.room = room;
    notifyListeners();
  }
  RoomOrder();
}