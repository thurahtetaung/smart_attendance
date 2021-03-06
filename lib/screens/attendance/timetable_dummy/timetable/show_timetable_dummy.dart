import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/timetable_dummy/timetable/list_timetable_dummy.dart';

import 'package:smart_attendance/services/database.dart';

class ShowTimetableDummy extends StatefulWidget {
  final int day;
  final int period;
  ShowTimetableDummy({this.day, this.period});
  @override
  _ShowTimetableState createState() =>
      _ShowTimetableState(day: this.day, period: this.period);
}

class _ShowTimetableState extends State<ShowTimetableDummy> {
  int day;
  int period;
  _ShowTimetableState({this.day, this.period});
  // List<TimeTable> timetable = [
  //   TimeTable(subject: 'AE', period: 1, room: 'L4', year: 5),
  //   TimeTable(subject: 'CA', period: 2, room: '10-6-6', year: 5),
  //   TimeTable(subject: 'DIP', period: 3, room: '1-3-18', year: 5),
  //   TimeTable(subject: 'Control', period: 4, room: 'L5', year: 5),
  //   TimeTable(subject: 'PLC', period: 5, room: '10-3-6', year: 5),
  //   TimeTable(subject: 'English', period: 6, room: '9-3-3', year: 5),
  // ];
  @override
  Widget build(BuildContext context) {
    final UserData2 userData2 =
        Provider.of<UserData2>(context) ?? UserData2(major: 'EcE', year: 1);
    return StreamProvider<List<TimeTable>>.value(
      initialData: [],
      value: DatabaseService(
              day: day, major: userData2.major, year: userData2.year)
          .daytimetables,
      child: ListTimetableDummy(period: period),
    );
  }
}
