import 'package:flutter/material.dart';
import 'package:smart_attendance/models/timetable_model.dart';

class TimetableTile extends StatelessWidget {
  final TimeTable timetable;
  final int weekday;
  TimetableTile({this.timetable, this.weekday});

  @override
  Widget build(BuildContext context) {
    if (weekday == timetable.day) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
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
