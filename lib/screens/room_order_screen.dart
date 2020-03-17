import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotel_app/model/room.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/screens/room_pick_screen.dart';
import 'package:hotel_app/screens/room_visitor_screen.dart';
import 'package:hotel_app/screens/date_picker_screen.dart';
import 'package:provider/provider.dart';
import 'package:hotel_app/bloc/room_order_bloc.dart';

class RoomOrderScreen extends StatefulWidget {
  @override
  RoomOrderScreenState createState() => RoomOrderScreenState();
}

class RoomOrderScreenState extends State<RoomOrderScreen> {
  int index = 0;
  RoomOrder roomOrder;
  List<Widget> _samplePages = [
    Center(
      child: RoomPickScreen(),
    ),
    Center(child: DatePickerScreen()),
    Center(child: RoomVisitorScreen()),
  ];
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  _onPageViewChange(int page) {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      index = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RoomsOrderBloc>(
          create: (_) => RoomsOrderBloc(),
          dispose: (_, RoomsOrderBloc roomsOrderBloc) =>
              roomsOrderBloc.dispose(),
        ),
      ],
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => RoomOrder(),
          child: Column(
            children: <Widget>[
              Flexible(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: _onPageViewChange,
                  itemCount: _samplePages.length,
                  itemBuilder: (BuildContext context, index) {
                    return _samplePages[index % _samplePages.length];
                  },
                ),
              ),
              Container(
                color: Colors.blue,
                child: Consumer<RoomOrder>(
                    builder: (context, schedule, _) {
//                      return StreamBuilder<RoomOrder>(
//                          stream: _roomsOrderBloc.getRoomOrder,
//                          builder: (context, snapshot) {
//                            if (snapshot.data != null) {
//                              roomOrder = snapshot.data;
//                              print("roomId: ${roomOrder.room.id}   context: ${context}");
//                            };
//                    print(schedule.getRoomState);
                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                if (index > 0)
                                  ButtonTheme(
                                    minWidth: 200.0,
                                    height: 40.0,
                                    child: FlatButton(
                                      child: Text(
                                        '<-',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        _controller.previousPage(
                                            duration: _kDuration, curve: _kCurve);
                                      },
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 200.0,
                                    height: 40.0,
                                  ),
                                if (index < (_samplePages.length - 1) && schedule.getRoomState != null)
                                  ButtonTheme(
                                    minWidth: 200.0,
                                    height: 40.0,
                                    child: FlatButton(
                                      child: Text(
                                        '->',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        _controller.nextPage(
                                            duration: _kDuration, curve: _kCurve);
                                      },
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 200.0,
                                    height: 40.0,
                                  )
                              ],
                            );
//                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
