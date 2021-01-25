import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/shared/constants.dart';

class AttendanceTile extends StatefulWidget {
  final AttendanceData subject;
  final int period;
  final Calendar subcount;
  AttendanceTile({this.subject, this.period, this.subcount});

  @override
  _AttendanceTileState createState() => _AttendanceTileState(
      subject: this.subject, period: this.period, subcount: this.subcount);
}

class _AttendanceTileState extends State<AttendanceTile> {
  AttendanceData subject;
  int period;
  Calendar subcount;
  _AttendanceTileState({this.subject, this.period, this.subcount});
  @override
  Widget build(BuildContext context) {
    //var random = new Random();
    int month = Provider.of(context);
    //print(month);
    //double temp = (random.nextDouble() + 0.7) / 2;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(widget.subject.subject),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width * 0.7,
              lineHeight: 10,
              progressColor: kPrimaryColor,
              percent:
                  subject.attendance[month - 1] / subcount.count[month - 1],
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 600,
            ),
          ),
          trailing: Text(
              '${(subject.attendance[month - 1] / subcount.count[month - 1] * 100).floor()}%'),
        ),
      ),
    );
  }
}
