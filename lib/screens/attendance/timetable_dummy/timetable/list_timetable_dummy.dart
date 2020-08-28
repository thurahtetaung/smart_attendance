import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/timetable_dummy/timetable/timetable_tile_dummy.dart';
import 'package:smart_attendance/services/database.dart';

class ListTimetableDummy extends StatefulWidget {
  final int period;
  ListTimetableDummy({this.period});
  @override
  _ListTimetableState createState() => _ListTimetableState(period: this.period);
}

class _ListTimetableState extends State<ListTimetableDummy> {
  int period;
  _ListTimetableState({this.period});
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context) ?? User(uid: null);
    final timetables = Provider.of<List<TimeTable>>(context) ?? [];
    List<TimeTable> testTimetables = timetables;
    List<TimeTable> dummy = [];
    // if (period != null) {
    //   testTimetables.retainWhere((element) => element.period == period);
    // }
    if (testTimetables.length >= 2) {
      for (var i = 0; i < testTimetables.length; i++) {
        if (i != testTimetables.length - 1) {
          if (testTimetables[i].subject == testTimetables[i + 1].subject) {
            testTimetables[i].editPeriod(testTimetables[i].period);
            testTimetables.removeAt(i + 1);
          }
        }
        dummy.add(testTimetables[i]);
      }
    } else {
      dummy = testTimetables;
    }
    //Remove lunch break from attendance list since it is not needed.
    dummy.removeWhere((element) => element.subject == 'Lunch Break');

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
            itemCount: dummy.length,
            itemBuilder: (context, index) {
              return TimetableTileDummy(
                timetable: dummy[index],
                userData2: userData2,
                period: period,
                index: index + 1,
              );
            },
          );
        });
  }
}
