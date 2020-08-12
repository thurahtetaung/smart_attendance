import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/components/rounded_button.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/services/database.dart';
import 'package:smart_attendance/shared/constants.dart';

class EditTimeTable extends StatefulWidget {
  @override
  _EditTimeTableState createState() => _EditTimeTableState();
}

class _EditTimeTableState extends State<EditTimeTable> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String subject = '';
  String error = '';
  int year = 5;
  int period = 1;
  String major = 'EcE';
  String room = '';
  int day = 1;
  var _majors = [
    'EcE',
    'C',
    'CEIT',
    'Tex',
    'Che',
    'McE',
    'Mech',
    'Met',
    'Mn',
    'Arch',
    'EP',
    'PE'
  ];
  var _years = [1, 2, 3, 4, 5, 6];
  var _days = [1, 2, 3, 4, 5];
  var _periods = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ?? User(uid: null);
    return StreamProvider<UserData2>.value(
        value: DatabaseService(uid: user.uid).userData2,
        child: Scaffold(
            // drawer: SideDrawer(),
            backgroundColor: kPrimaryLightColor[200],
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text('Timetable'),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your year',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<int>(
                            items: _years
                                .map((int dropDownIntItem) =>
                                    DropdownMenuItem<int>(
                                      value: dropDownIntItem,
                                      child: Text('$dropDownIntItem'),
                                    ))
                                .toList(),
                            onChanged: (int newIntValueSelected) {
                              setState(() {
                                year = newIntValueSelected;
                              });
                            },
                            value: year,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your day',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<int>(
                            items: _days
                                .map((int dropDownIntItem) =>
                                    DropdownMenuItem<int>(
                                      value: dropDownIntItem,
                                      child: Text('$dropDownIntItem'),
                                    ))
                                .toList(),
                            onChanged: (int newIntValueSelected) {
                              setState(() {
                                day = newIntValueSelected;
                              });
                            },
                            value: day,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your major',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<String>(
                            items: _majors
                                .map((String dropDownStringItem) =>
                                    DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    ))
                                .toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                major = newValueSelected;
                              });
                            },
                            value: major,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your period',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<int>(
                            items: _periods
                                .map((int dropDownIntItem) =>
                                    DropdownMenuItem<int>(
                                      value: dropDownIntItem,
                                      child: Text('$dropDownIntItem'),
                                    ))
                                .toList(),
                            onChanged: (int newIntValueSelected) {
                              setState(() {
                                period = newIntValueSelected;
                              });
                            },
                            value: period,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your room',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your room' : null,
                        onChanged: (val) {
                          setState(() {
                            room = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your subject',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your subject name' : null,
                        onChanged: (val) {
                          setState(() {
                            subject = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundedButton(
                      text: "Register",
                      press: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService().addTimetableData(
                              subject: subject,
                              major: major,
                              year: year,
                              period: period,
                              room: room,
                              day: day);
                        }
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )));
  }
}
