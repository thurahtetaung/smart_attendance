import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/timetable/timetable_tile.dart';
import 'package:smart_attendance/services/database.dart';

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
    final User user = Provider.of<User>(context) ?? User(uid: null);
    final timetables = Provider.of<List<TimeTable>>(context) ?? [];
    return StreamBuilder<UserData2>(
        stream: DatabaseService(uid: user.uid).userData2,
        builder: (context, snapshot) {
          UserData2 userData2 = snapshot.data ??
              UserData2(
                  uid: '0',
                  major: 'test',
                  name: 'test',
                  year: 0,
                  rollNumber: 0);
          return ListView.builder(
            itemCount: timetables.length,
            itemBuilder: (context, index) {
              return TimetableTile(
                timetable: timetables[index],
                weekday: day,
                userData2: userData2,
              );
            },
          );
        });
  }
}
