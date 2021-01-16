import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/attendance_services/list_attendance.dart';
import 'package:smart_attendance/services/database.dart';

class ShowAttendance extends StatefulWidget {
  final int day;
  final int period;
  ShowAttendance({this.day, this.period});
  @override
  _ShowTimetableState createState() => _ShowTimetableState(
        day: this.day,
        period: this.period,
      );
}

class _ShowTimetableState extends State<ShowAttendance> {
  int day;
  int period;
  _ShowTimetableState({this.day, this.period});
  @override
  Widget build(BuildContext context) {
    final UserData2 userData2 =
        Provider.of<UserData2>(context) ?? UserData2(major: 'EcE', year: 1);
    return StreamProvider<List<AttendanceData>>.value(
      initialData: [],
      value: DatabaseService(uid: userData2.uid).attendancedata,
      child: ListAttendance(period: period),
    );
  }
}
