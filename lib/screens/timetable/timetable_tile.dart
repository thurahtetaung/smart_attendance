import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class TimetableTile extends StatelessWidget {
  final TimeTable timetable;
  final int weekday;
  TimetableTile({this.timetable, this.weekday});

  @override
  Widget build(BuildContext context) {
    final UserData2 userData2 = Provider.of<UserData2>(context);
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
