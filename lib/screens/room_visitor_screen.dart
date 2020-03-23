import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/model/room_order.dart';
import 'package:hotel_app/model/visitor.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RoomVisitorScreen extends StatefulWidget {
  @override
  _RoomVisitorScreenState createState() => _RoomVisitorScreenState();
}

class _RoomVisitorScreenState extends State<RoomVisitorScreen> {
  Visitor visitor = new Visitor();
  int count_of_persons;
  bool isInit;
  var cardFormatter = new MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});

  var cardExpDateFormatter = new MaskTextInputFormatter(
      mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  final nameController = TextEditingController();
  final documentsController = TextEditingController();
  final cardController = TextEditingController();
  final cardExpDateController = TextEditingController();
  final phoneController = TextEditingController();

//  List<TextEditingController> controllers = [
//    nameController, documentsController, cardController, cardExpDateController, phoneController
//  ];

  @override
  void dispose() {
    nameController.dispose();
    documentsController.dispose();
    cardController.dispose();
    cardExpDateController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isInit = true;
    super.initState();
  }

  void _fillFields() {
    nameController.text = visitor.name;
    documentsController.text = visitor.documents;
    cardController.text = visitor.card_number;
    cardExpDateController.text = visitor.card_exp_date;
    phoneController.text = visitor.phone;
//    nameController.selection =
//        TextSelection.collapsed(offset: nameController.text.length);
//    documentsController.selection =
//        TextSelection.collapsed(offset: documentsController.text.length);
//    cardController.selection =
//        TextSelection.collapsed(offset: cardController.text.length);
//    cardExpDateController.selection =
//        TextSelection.collapsed(offset: cardExpDateController.text.length);
//    phoneController.selection =
//        TextSelection.collapsed(offset: phoneController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<RoomOrder>(context);
    if (isInit) {
      if (schedule.getCountOfPeronsState != null)
        count_of_persons = schedule.getCountOfPeronsState;
      if (schedule.getVisitorState != null) {
        visitor = schedule.getVisitorState;
        this._fillFields();
      }
      isInit = false;
    }
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: GestureDetector(
          onTap: () {
//                    FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(padding: EdgeInsets.all(30), children: <Widget>[
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
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        labelText: 'Имя',
                        labelStyle: TextStyle(color: Colors.blue)),
                    onChanged: (text) {
                      visitor.name = text;
                      schedule.setVisitorState = visitor;
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
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        labelText: 'Документы',
                        labelStyle: TextStyle(color: Colors.blue)),
                    onChanged: (text) {
                      visitor.documents = text;
                      schedule.setVisitorState = visitor;
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            labelText: 'Карта',
                            hintText: "0000 0000 0000 0000",
                            labelStyle: TextStyle(color: Colors.blue)),
                        onChanged: (text) {
                          visitor.card_number = text;
                          schedule.setVisitorState = visitor;
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0),
                            ),
                            labelText: 'Exp.date',
                            hintText: "MM/YY",
                            labelStyle: TextStyle(color: Colors.blue)),
                        onChanged: (text) {
                          visitor.card_exp_date = text;
                          schedule.setVisitorState = visitor;
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
                            borderSide:
                                new BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        labelText: 'Номер телефона',
                        labelStyle: TextStyle(color: Colors.blue)),
                    onChanged: (text) {
                      visitor.phone = text;
                      schedule.setVisitorState = visitor;
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                      color: Colors.blue, style: BorderStyle.solid, width: 2.0),
                ),
                child: DropdownButton<int>(
                  hint: Text(
                    "Кол-во человек",
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  value: count_of_persons,
                  itemHeight: 60,
                  isExpanded: true,
                  style: TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (int newValue) {
                    setState(() {
                      count_of_persons = newValue;
                      schedule.setCountOfPersonsState = count_of_persons;
                    });
                  },
                  items: <int>[1, 2, 3, 4, 5]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
            ),

//            Padding(
//              padding: const EdgeInsets.all(4.0),
//              child: SizedBox(
//                  height: 60,
//                  child: TextField(
//                    controller: phoneController,
//                    autocorrect: false,
//                    keyboardType: TextInputType.number,
//                    style: TextStyle(fontSize: 16),
//                    decoration: InputDecoration(
//                        focusedBorder: OutlineInputBorder(
//                            borderSide:
//                                new BorderSide(color: Colors.blue, width: 2.0),
//                            borderRadius:
//                                BorderRadius.all(Radius.circular(30))),
//                        enabledBorder: OutlineInputBorder(
//                          borderSide:
//                              BorderSide(color: Colors.blue, width: 2.0),
//                        ),
//                        labelText: 'Номер телефона',
//                        labelStyle: TextStyle(color: Colors.blue)),
//                    onChanged: (text) {
//                      visitor.phone = text;
//                      schedule.setVisitorState = visitor;
//                    },
//                  )),
//            )
          ]),
        )));
  }
}
