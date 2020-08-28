import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_attendance/models/user.dart';

class AttendanceTile extends StatelessWidget {
  final AttendanceData subject;
  final int period;
  AttendanceTile({this.subject, this.period});

  @override
  Widget build(BuildContext context) {
    var random = new Random();
    double temp = (random.nextDouble() + 0.7) / 2;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          title: Text(subject.subject),
          subtitle: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: LinearPercentIndicator(
              width: 260,
              percent: temp,
              animation: true,
              animateFromLastPercent: true,
              animationDuration: 1,
            ),
          ),
          trailing: Text('${(temp * 100).floor()}%'),
        ),
      ),
    );
  }
}
