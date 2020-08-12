import 'package:flutter/material.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class TimetableTile extends StatelessWidget {
  final TimeTable timetable;
  final UserData2 userData2;
  TimetableTile({this.timetable, this.userData2});

  @override
  Widget build(BuildContext context) {
    Map time = timeSlot();

    if (userData2 != null && timetable != null) {
      TimeOfDay start = time[timetable.period][0];
      String startstring = start.format(context);
      // print(startstring);
      TimeOfDay end = time[timetable.period][1];
      String endstring = end.format(context);
      // print(endstring);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Card(
          child: ListTile(
            onTap: () {},
            title: Text(timetable.subject),
            subtitle: Text('$startstring - $endstring'),
            trailing: Text('Room ( ${timetable.room} )'),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Map timeSlot() {
    final Map timeslot = new Map();
    timeslot[1] = [
      TimeOfDay(hour: 8, minute: 0),
      TimeOfDay(hour: 8, minute: 50)
    ];
    timeslot['1,2'] = [
      TimeOfDay(hour: 8, minute: 0),
      TimeOfDay(hour: 9, minute: 50)
    ];
    timeslot[2] = [
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 9, minute: 50)
    ];
    timeslot['2,3'] = [
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 10, minute: 50)
    ];
    timeslot[3] = [
      TimeOfDay(hour: 10, minute: 0),
      TimeOfDay(hour: 10, minute: 50)
    ];
    timeslot['3,4'] = [
      TimeOfDay(hour: 10, minute: 0),
      TimeOfDay(hour: 11, minute: 50)
    ];
    timeslot[4] = [
      TimeOfDay(hour: 11, minute: 0),
      TimeOfDay(hour: 11, minute: 50)
    ];
    timeslot['4,5'] = [
      TimeOfDay(hour: 11, minute: 0),
      TimeOfDay(hour: 12, minute: 50)
    ];
    timeslot[5] = [
      TimeOfDay(hour: 12, minute: 0),
      TimeOfDay(hour: 12, minute: 50)
    ];
    timeslot['5,6'] = [
      TimeOfDay(hour: 12, minute: 0),
      TimeOfDay(hour: 13, minute: 50)
    ];
    timeslot[6] = [
      TimeOfDay(hour: 13, minute: 0),
      TimeOfDay(hour: 13, minute: 50)
    ];
    timeslot['6,7'] = [
      TimeOfDay(hour: 13, minute: 0),
      TimeOfDay(hour: 14, minute: 50)
    ];
    timeslot[7] = [
      TimeOfDay(hour: 14, minute: 0),
      TimeOfDay(hour: 14, minute: 50)
    ];
    timeslot['7,8'] = [
      TimeOfDay(hour: 14, minute: 0),
      TimeOfDay(hour: 15, minute: 50)
    ];
    timeslot[8] = [
      TimeOfDay(hour: 15, minute: 0),
      TimeOfDay(hour: 15, minute: 50)
    ];
    timeslot['8,9'] = [
      TimeOfDay(hour: 15, minute: 0),
      TimeOfDay(hour: 16, minute: 50)
    ];
    timeslot[9] = [
      TimeOfDay(hour: 16, minute: 0),
      TimeOfDay(hour: 16, minute: 50)
    ];

    return timeslot;
  }
}
