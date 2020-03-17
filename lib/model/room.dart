import 'package:flutter/cupertino.dart';

class Room with ChangeNotifier{
  int id;
  String number;
  int width;
  int height;
  int status;
  double price;

  Room(this.id, this.number, this.width, this.height, this.status, this.price);
}
