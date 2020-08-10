import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class TimetableTile extends StatelessWidget {
  final TimeTable timetable;
  final int weekday;
  final UserData2 userData2;
  TimetableTile({this.timetable, this.weekday, this.userData2});

  @override
  Widget build(BuildContext context) {
    if (weekday == timetable.day && userData2.major == timetable.major) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Card(
          child: ListTile(
            onTap: () {},
            title: Text(timetable.subject),
            subtitle: Text('period - ${timetable.period}'),
            trailing: Text('Room ( ${timetable.room} )'),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
