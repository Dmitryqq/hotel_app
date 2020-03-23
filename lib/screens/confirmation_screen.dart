import 'package:flutter/material.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/screens/home_screen.dart';
import 'package:intl/intl.dart';

class ConfifmationScreen extends StatelessWidget {
  final RoomOrder roomOrder;

  ConfifmationScreen({Key key, @required this.roomOrder}) : super(key: key);

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(),
    );
  }
  
  TextStyle textStyle(){
    return TextStyle(fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      color: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Text("Personal info", style: TextStyle(fontSize: 22),),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            padding: const EdgeInsets.all(10.0),
            decoration: myBoxDecoration(),
            child: Column(children: <Widget>[
              Center(
                child: Text(
                  "Имя: ${roomOrder.visitor.name}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Документы: ${roomOrder.visitor.documents}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Номер карты: ${roomOrder.visitor.card_number}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Exp.date: ${roomOrder.visitor.card_exp_date}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Номер телефона: ${roomOrder.visitor.phone}",
                  style: textStyle(),
                ),
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            child: Text("Room info", style: TextStyle(fontSize: 22),),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            padding: const EdgeInsets.all(10.0),
            decoration: myBoxDecoration(),
            child: Column(children: <Widget>[
              Center(
                child: Text(
                  "Номер: ${roomOrder.room.number}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Цена: ${roomOrder.room.price}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Check-in date: ${DateFormat('dd.MM.yyyy kk:mm').format(roomOrder.datePeriod.start)}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Check-out date: ${DateFormat('dd.MM.yyyy kk:mm').format(roomOrder.datePeriod.end)}",
                  style: textStyle(),
                ),
              ),
              Center(
                child: Text(
                  "Кол-во человек: ${roomOrder.count_of_persons}",
                  style: textStyle(),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go back!'),
                ),
                RaisedButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                        ModalRoute.withName('/')
//                      MaterialPageRoute(
//                        builder: (context) => HomeScreen(),
//                      ),
                    );
                  },
                  child: Text('Check-in!'),
                ),
              ],
            ),
          ),
        ],
      )
//        ]),
          ),
    );
  }
}
