import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/attendance_services/attendance_tile.dart';
import 'package:smart_attendance/screens/attendance/monthly_attendance.dart';

class ListAttendance extends StatefulWidget {
  final int period;
  ListAttendance({this.period});
  @override
  _ListAttendanceState createState() => _ListAttendanceState(
        period: this.period,
      );
}

class _ListAttendanceState extends State<ListAttendance> {
  int period;

  _ListAttendanceState({
    this.period,
  });
  @override
  Widget build(BuildContext context) {
    final subjects = Provider.of<List<AttendanceData>>(context) ?? [];
    final calendarList = Provider.of<List<Calendar>>(context) ?? [];
    //Remove lunch break from attendance list since it is not needed.
    if (calendarList.length == 11) calendarList.removeAt(6);

    // dummy.removeWhere((element) => element.subject == 'Lunch Break');
    // print('$subjects');
    return ListView.builder(
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return StreamProvider.value(
          initialData: 1,
          value: MonthlyAttendanceScreenState().month,
          child: AttendanceTile(
            subject: subjects[index],
            period: period,
            subcount: calendarList[index],
          ),
        );
      },
    );
  }
}
