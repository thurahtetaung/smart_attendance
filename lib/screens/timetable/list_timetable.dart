import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/screens/timetable/timetable_tile.dart';

class ListTimetable extends StatefulWidget {
  final int day;
  ListTimetable(this.day);
  @override
  _ListTimetableState createState() => _ListTimetableState(this.day);
}

class _ListTimetableState extends State<ListTimetable> {
  int day;
  _ListTimetableState(this.day);
  @override
  Widget build(BuildContext context) {
    final timetables = Provider.of<List<TimeTable>>(context) ?? [];
    return ListView.builder(
      itemCount: timetables.length,
      itemBuilder: (context, index) {
        return TimetableTile(
          timetable: timetables[index],
          weekday: day,
        );
      },
    );
  }
}
