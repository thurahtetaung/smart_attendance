import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/timetable/show_timetable.dart';
import 'package:smart_attendance/services/database.dart';
import 'package:smart_attendance/shared/constants.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ?? User(uid: null);
    final List<TimeOfDay> periods = [];
    //creating a list of periods in time of day
    for (var i = 0; i < 9; i++) {
      periods.add(TimeOfDay(hour: 8 + i, minute: 0));
    }
    // To check whether to show a class or not according to current time
    bool free = now.weekday > 5 || (now.weekday == 3 && now.hour > 12);
    double nowdouble = TimeOfDay.now().hour.toDouble() +
        TimeOfDay.now().minute.toDouble() / 60.0;
    int period;
    bool check = false;
    List<int> index = periods.asMap().keys.toList();
    for (var value in index) {
      check = nowdouble < periods[value].hour.toDouble();
      if (check) {
        period = value;
        break;
      }
    }
    if (period == null) {
      period = 10;
      setState(() => free = true);
    }
    //print(period);
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
          title: Text('Attendance'),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),

        body: free
            ? Container(
                child: Text('No class right now. You are free!'),
              )
            : ShowTimetable(
                day: now.weekday,
                period: period,
              ),
      ),
    );
  }
}
