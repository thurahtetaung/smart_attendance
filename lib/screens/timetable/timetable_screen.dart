import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/timetable/show_timetable.dart';
import 'package:smart_attendance/services/database.dart';
import 'package:smart_attendance/shared/constants.dart';

class TimeTableBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) ?? User(uid: null);
    return StreamProvider<UserData2>.value(
      value: DatabaseService(uid: user.uid).userData2,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          // drawer: SideDrawer(),
          backgroundColor: kPrimaryLightColor[200],
          appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
      ),
    );
  }
}
