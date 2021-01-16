import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/attendance_services/show_attendance.dart';
import 'package:smart_attendance/shared/constants.dart';

int dp = 1;

class MonthlyAttendanceScreen extends StatefulWidget {
  @override
  MonthlyAttendanceScreenState createState() => MonthlyAttendanceScreenState();
}

class MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
  Stream<int> get month {
    return Stream.value(dp);
  }

  @override
  Widget build(BuildContext context) {
    final subjects = Provider.of<List<AttendanceData>>(context) ?? [];
    final calendarList = Provider.of<List<Calendar>>(context) ?? [];

    // Remmoving Lunch Break from list
    //print(calendarList.length);
    if (calendarList.length == 11) calendarList.removeAt(6);
    List sum = [];
    //print(calendarList[0].count.length);
    for (int i = 0; i < calendarList[0].count.length; i++) {
      double subatd = 0;
      for (int j = 0; j < calendarList.length; j++) {
        subatd += subjects[j].attendance[i] / calendarList[j].count[i];
      }
      sum.add(subatd / calendarList.length);
    }
    //print(sum);
    var random = new Random();
    //double temp = (random.nextDouble() + 0.7) / 2;
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
                  color: kPrimaryLightColor[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                constraints: BoxConstraints(minWidth: 20, maxWidth: 145),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      isExpanded: true,
                      value: dp,
                      items: [
                        DropdownMenuItem(
                            value: 1,
                            child: Center(
                              child: Text(
                                'January',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 2,
                            child: Center(
                              child: Text(
                                'February',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 3,
                            child: Center(
                              child: Text(
                                'March',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 4,
                            child: Center(
                              child: Text(
                                'April',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 5,
                            child: Center(
                              child: Text(
                                'May',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 6,
                            child: Center(
                              child: Text(
                                'June',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 7,
                            child: Center(
                              child: Text(
                                'July',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 8,
                            child: Center(
                              child: Text(
                                'August',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 9,
                            child: Center(
                              child: Text(
                                'September',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 10,
                            child: Center(
                              child: Text(
                                'October',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 11,
                            child: Center(
                              child: Text(
                                'November',
                              ),
                            )),
                        DropdownMenuItem(
                            value: 12,
                            child: Center(
                              child: Text(
                                'December',
                              ),
                            )),
                      ],
                      onChanged: (int newValue) {
                        setState(() {
                          dp = newValue;
                        });
                      },
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.34,
                  lineWidth: 10,
                  percent: sum[dp - 1],
                  progressColor: kPrimaryColor,
                  circularStrokeCap: CircularStrokeCap.round,
                  animateFromLastPercent: true,
                  animation: true,
                  center: Text(
                    '${(sum[dp - 1] * 100).round()}%',
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
