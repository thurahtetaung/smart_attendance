import 'package:flutter/material.dart';
import 'package:smart_attendance/screens/timetable/show_timetable.dart';
import 'package:smart_attendance/screens/home/side_drawer.dart';
import 'package:smart_attendance/shared/constants.dart';

class TimeTableBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        drawer: SideDrawer(),
        backgroundColor: kPrimaryLightColor[200],
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Mon',
              ),
              Tab(
                text: 'Tue',
              ),
              Tab(
                text: 'Wed',
              ),
              Tab(
                text: 'Thu',
              ),
              Tab(
                text: 'Fri',
              ),
            ],
          ),
          title: Text('Timetable'),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: TabBarView(children: [
          ShowTimetable(1),
          ShowTimetable(2),
          ShowTimetable(3),
          ShowTimetable(4),
          ShowTimetable(5),
        ]),
      ),
    );
  }
}
