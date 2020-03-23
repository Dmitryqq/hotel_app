import 'package:flutter/cupertino.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:hotel_app/model/room.dart';
import 'package:hotel_app/model/visitor.dart';

class RoomOrder with ChangeNotifier{
  Room room;
  Visitor visitor;
  DatePeriod datePeriod;
  int count_of_persons;

  Room get getRoomState => room;
  set setRoomState(Room room){
    this.room = room;
    notifyListeners();
  }

  Visitor get getVisitorState => visitor;
  set setVisitorState(Visitor visitor){
    this.visitor = visitor;
    notifyListeners();
  }

  DatePeriod get getDatePeriodState => datePeriod;
  set setDatePeriodState(DatePeriod datePeriod){
    this.datePeriod = datePeriod;
    notifyListeners();
  }

  int get getCountOfPeronsState => count_of_persons;
  set setCountOfPersonsState(int count_of_persons){
    this.count_of_persons = count_of_persons;
    notifyListeners();
  }

  RoomOrder get getState => this;
  RoomOrder();
}