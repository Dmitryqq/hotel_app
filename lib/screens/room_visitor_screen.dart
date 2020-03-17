import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/bloc/room_order_bloc.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/model/visitor.dart';
import 'package:hotel_app/modules/http.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RoomVisitorScreen extends StatefulWidget {
  @override
  _RoomVisitorScreenState createState() => _RoomVisitorScreenState();
}

class _RoomVisitorScreenState extends State<RoomVisitorScreen> {
  Visitor visitor;
  String dropdownValue;
  var cardFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});

  var cardExpDateFormatter = new MaskTextInputFormatter(
      mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  final nameController = TextEditingController();
  final documentsController = TextEditingController();
  final cardController = TextEditingController();
  final cardExpDateController = TextEditingController();
  final phoneController = TextEditingController();

  addVisitor() async {
    var result = await http_post("visitors", {
      "name": visitor.name,
      "documents": visitor.documents,
      "card_number": visitor.card_number.replaceAll(' ', ''),
      "card_exp_date": visitor.card_exp_date,
      "phone": visitor.phone
    });
    print(result.ok);
  }

  @override
  void dispose() {
    nameController.dispose();
    documentsController.dispose();
    cardController.dispose();
    cardExpDateController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void fillFields() {
    nameController.text = visitor.name;
    documentsController.text = visitor.documents;
    cardController.text = visitor.card_number;
    cardExpDateController.text = visitor.card_exp_date;
    phoneController.text = visitor.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Consumer<RoomsOrderBloc>(
            builder: (context, _roomsOrderBloc, child) {
          return StreamBuilder<RoomOrder>(
              stream: _roomsOrderBloc.getRoomOrder,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  visitor = snapshot.data.visitor;
                  this.fillFields();
                }
                return SafeArea(
                    child: GestureDetector(
                  onTap: () {
//                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child:
                      ListView(padding: EdgeInsets.all(30), children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                          height: 60,
                          child: TextField(
                            controller: nameController,
                            autocorrect: false,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                labelText: 'Имя',
                                labelStyle: TextStyle(color: Colors.blue)),
                            onChanged: (text) {
                              visitor.name = text;
                              _roomsOrderBloc.setOrder.add(visitor);
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                          height: 60,
                          child: TextField(
                            controller: documentsController,
                            autocorrect: false,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                labelText: 'Документы',
                                labelStyle: TextStyle(color: Colors.blue)),
                            onChanged: (text) {
                              visitor.documents = text;
                              _roomsOrderBloc.setOrder.add(visitor);
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 4,
                              child: TextField(
                                controller: cardController,
                                inputFormatters: [cardFormatter],
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                    ),
                                    labelText: 'Карта',
                                    hintText: "0000 0000 0000 0000",
                                    labelStyle: TextStyle(color: Colors.blue)),
                                onChanged: (text) {
                                  visitor.card_number = text;
                                  _roomsOrderBloc.setOrder.add(visitor);
                                },
                              )),
                          Expanded(
                              flex: 2,
                              child: TextField(
                                controller: cardExpDateController,
                                inputFormatters: [cardExpDateFormatter],
                                autocorrect: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.blue, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 2.0),
                                    ),
                                    labelText: 'Exp.date',
                                    hintText: "MM/YY",
                                    labelStyle: TextStyle(color: Colors.blue)),
                                onChanged: (text) {
                                  visitor.card_exp_date = text;
                                  _roomsOrderBloc.setOrder.add(visitor);
                                },
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SizedBox(
                          height: 60,
                          child: TextField(
                            controller: phoneController,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Colors.blue, width: 2.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                labelText: 'Номер телефона',
                                labelStyle: TextStyle(color: Colors.blue)),
                            onChanged: (text) {
                              visitor.phone = text;
                              _roomsOrderBloc.setOrder.add(visitor);
                            },
                          )),
                    ),
//                    SizedBox(
//                        height: 60,
//                        child: TextField(
//                          controller: documentsController,
//                          autocorrect: false,
//                          style: TextStyle(fontSize: 18),
//                          decoration: InputDecoration(
//                              border: OutlineInputBorder(
//                                  borderRadius:
//                                      BorderRadius.all(Radius.circular(15))),
//                              labelText: 'Документы'),
//                          onChanged: (text) {
//                            visitor.documents = text;
//                            _roomsOrderBloc.setVisitor.add(visitor);
//                          },
//                        )),
//                    SizedBox(
//                        width: 300.0,
//                        child: TextFormField(
//                          controller: cardController,
//                          keyboardType: TextInputType.numberWithOptions(),
//                          decoration: InputDecoration(labelText: 'Номер карты'),
//                          onChanged: (text) {
//                            visitor.card_number = text;
//                            _roomsOrderBloc.setVisitor.add(visitor);
//                          },
//                        )),
//                    SizedBox(
//                        width: 300.0,
//                        child: TextFormField(
//                          controller: phoneController,
//                          keyboardType: TextInputType.numberWithOptions(),
//                          decoration:
//                              InputDecoration(labelText: 'Номер телефона'),
//                          onChanged: (text) {
//                            visitor.phone = text;
//                            _roomsOrderBloc.setVisitor.add(visitor);
//                          },
//                        )),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 2.0),
                        ),
                        child: DropdownButton<String>(
                          hint: Text(
                            "Кол-во человек",
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                          value: dropdownValue,
                          itemHeight: 60,
                          isExpanded: true,
                          style: TextStyle(color: Colors.blue),
                          underline: Container(
                            height: 0,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <int>[1, 2, 3, 4, 5]
                              .map<DropdownMenuItem<String>>((int value) {
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

//                      SizedBox(
//                          width: 300.0,
//                          child: TextFormField(
//                            decoration:
//                                InputDecoration(labelText: 'Кол-во человек'),
//                          )),
                    SizedBox(
                        width: 300.0,
                        child: TextFormField(
                          maxLength: 400,
                          decoration:
                              InputDecoration(labelText: 'Особые пожелания'),
                        )),
                    RaisedButton(
                      child: Text("Create"),
                      onPressed: addVisitor,
                    )

//                      Text(visitor.toString())
                  ]),
                ));
              });
        }));
  }
}
