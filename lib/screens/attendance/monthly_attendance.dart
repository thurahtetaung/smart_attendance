import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smart_attendance/screens/attendance/attendance_services/show_attendance.dart';
import 'package:smart_attendance/shared/constants.dart';

class MonthlyAttendanceScreen extends StatefulWidget {
  @override
  _MonthlyAttendanceScreenState createState() =>
      _MonthlyAttendanceScreenState();
}

class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  int dp = DateTime.now().month;
  @override
  Widget build(BuildContext context) {
    var random = new Random();
    double temp = (random.nextDouble() + 0.7) / 2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: BoxConstraints(minWidth: 20, maxWidth: 145),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      isExpanded: true,
                      value: dp,
                      onChanged: (value) {
                        setState(() {
                          dp = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(value: 1, child: Text('January')),
                        DropdownMenuItem(value: 2, child: Text('February')),
                        DropdownMenuItem(value: 3, child: Text('March')),
                        DropdownMenuItem(value: 4, child: Text('April')),
                        DropdownMenuItem(value: 5, child: Text('May')),
                        DropdownMenuItem(value: 6, child: Text('June')),
                        DropdownMenuItem(value: 7, child: Text('July')),
                        DropdownMenuItem(value: 8, child: Text('August')),
                        DropdownMenuItem(value: 9, child: Text('September')),
                        DropdownMenuItem(value: 10, child: Text('October')),
                        DropdownMenuItem(value: 11, child: Text('November')),
                        DropdownMenuItem(value: 12, child: Text('December')),
                      ],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CircularPercentIndicator(
                  radius: 120,
                  lineWidth: 10,
                  percent: temp,
                  progressColor: kPrimaryColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  animateFromLastPercent: true,
                  animation: true,
                  center: Text(
                    '${(temp * 100).round()}%',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: ShowAttendance(),
          ),
        )
      ],
    );
  }
}
