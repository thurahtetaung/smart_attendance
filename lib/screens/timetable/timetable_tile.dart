import 'package:flutter/material.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class TimetableTile extends StatelessWidget {
  final TimeTable timetable;

  final UserData2 userData2;
  TimetableTile({this.timetable, this.userData2});

  @override
  Widget build(BuildContext context) {
    if (userData2 != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
