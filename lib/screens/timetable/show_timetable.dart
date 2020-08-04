import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/screens/timetable/list_timetable.dart';
import 'package:smart_attendance/services/database.dart';

class ShowTimetable extends StatefulWidget {
  final int day;
  ShowTimetable(this.day);
  @override
  _ShowTimetableState createState() => _ShowTimetableState(this.day);
}

class _ShowTimetableState extends State<ShowTimetable> {
  int day;
  _ShowTimetableState(this.day);
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
    return StreamProvider<List<TimeTable>>.value(
      initialData: [],
      value: DatabaseService().timetables,
      child: ListTimetable(day),
    );
  }
}
