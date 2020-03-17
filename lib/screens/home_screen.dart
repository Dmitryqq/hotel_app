import 'package:flutter/material.dart';
import 'package:hotel_app/screens/room_order_screen.dart';
import '../model/room.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildIcon(Room room) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(padding: EdgeInsets.all(30), children: <Widget>[
          ButtonTheme(
            minWidth: 200.0,
            height: 100.0,
            child: RaisedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RoomOrderScreen())),
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Заказать комнату',
                  style: TextStyle(fontSize: 20)),
            ),
          ),
        ]),
      ),
    );
  }
}
