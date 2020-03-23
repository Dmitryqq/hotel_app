import 'package:flutter/material.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/modules/http.dart';
import 'package:provider/provider.dart';
import '../model/room.dart';
import 'package:http/http.dart';

class RoomPickScreen extends StatefulWidget {
  @override
  RoomPickScreenState createState() => RoomPickScreenState();
}

class RoomPickScreenState extends State<RoomPickScreen> {
  List<Room> rooms = [];

  Future<void> refreshRooms() async {
    var result = await http_get('rooms');
    if (result.ok) {
      setState(() {
        rooms.clear();
        var in_rooms = result.data as List<dynamic>;
        in_rooms.forEach((in_room) {
          rooms.add(Room(
              in_room['id'],
              in_room['number'],
              in_room['width'],
              in_room['height'],
              in_room['status']['id'],
              in_room['price'].toDouble()));
        });
      });
    }
  }

  int i = 0;

  _makeGetRequest() async {
    // make GET request
    String url = 'https://jsonplaceholder.typicode.com/posts';
    Response response = await get(url);
    // sample info available in response
    int statusCode = response.statusCode;
    Map<String, String> headers = response.headers;
    String contentType = headers['content-type'];
    String json = response.body;
    // TODO convert json to object...
  }

  Widget _buildIcon(Room room, schedule) {
    return GestureDetector(
      onTap: () {
        setState(() {
          schedule.setRoomState = room;
        });
      },
      child: SizedBox(
          width: room.width.toDouble(),
          height: room.height.toDouble(),
          child: Container(
              decoration: schedule.getRoomState != null &&
                      schedule.getRoomState.id != room.id
                  ? BoxDecoration(
                      border: Border.all(
                          width: 10,
                          color: Colors.white,
                          style: BorderStyle.none))
                  : null,
              child: Card(
                  color: room.status == 1
                      ? Colors.indigoAccent
                      : room.status == 2 ? Colors.yellow : Colors.deepOrange,
                  child: Center(
                      child: Text(room.number.toString(),
                          style:
                              TextStyle(color: Colors.white, fontSize: 28)))))),
    );
  }

  @override
  void initState() {
    super.initState();
    this.refreshRooms();
  }

  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<RoomOrder>(context);
    FocusScope.of(context).requestFocus(new FocusNode());
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      if (rooms.isNotEmpty)
                        for (MapEntry map in ([
                          for (i = 0; i < 3; i += 1) rooms[i]
                        ]).asMap().entries)
                          _buildIcon(map.value, schedule)
                    ],
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: Column(),
//                                Text(
//                              room_number.toString(),
//                              style: TextStyle(color: Colors.white),
//                            ),
                  flex: 2,
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (rooms.isNotEmpty)
                        for (MapEntry map in ([
                          for (i = 3; i < 5; i += 1) rooms[i]
                        ]).asMap().entries)
                          _buildIcon(map.value, schedule)
                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
