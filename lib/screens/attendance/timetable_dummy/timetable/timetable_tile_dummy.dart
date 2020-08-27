import 'package:flutter/material.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class TimetableTileDummy extends StatelessWidget {
  final TimeTable timetable;
  final UserData2 userData2;
  final int period;
  TimetableTileDummy({this.timetable, this.userData2, this.period});

  @override
  Widget build(BuildContext context) {
    Map time = timeSlot();
    bool selected = false;
    String tperiod = timetable.period.toString();
    if (tperiod.length > 1) {
      if (int.parse(tperiod[0]) == period || int.parse(tperiod[2]) == period) {
        selected = true;
      }
    } else {
      if (int.parse(tperiod[0]) == period) {
        selected = true;
      }
    }
    if (userData2 != null && timetable != null) {
      TimeOfDay start = time[timetable.period][0];
      String startstring = start.format(context);
      // print(startstring);
      TimeOfDay end = time[timetable.period][1];
      String endstring = end.format(context);
      // print(period);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: Card(
          child: ListTile(
            title: Text(timetable.subject),
            subtitle: Text('$startstring - $endstring'),
            enabled: selected,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    disabledColor: Colors.grey,
                    color: Colors.green,
                    icon: Icon(
                      Icons.event_available,
                    ),
                    onPressed: !selected ? null : () {}),
                IconButton(
                    disabledColor: Colors.grey,
                    color: Colors.red,
                    icon: Icon(
                      Icons.event_busy,
                    ),
                    onPressed: !selected ? null : () {}),
              ],
            ),
            // trailing: Text('Room ( ${timetable.room} )'),
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
