import 'package:flutter/material.dart';
import 'package:smart_attendance/screens/attendance/attendance_screen.dart';
import 'package:smart_attendance/screens/home/home.dart';
import 'package:smart_attendance/screens/home/settings_form.dart';
import 'package:smart_attendance/screens/timetable/timetable_screen.dart';
import 'package:smart_attendance/screens/wrapper.dart';
import 'package:smart_attendance/services/auth.dart';
import 'package:smart_attendance/shared/constants.dart';

class SideDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return Drawer(
      // column holds all the widgets in the drawer
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
          Expanded(
            // ListView contains a group of widgets that scroll inside the drawer
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                  },
                ),
                ListTile(
                  title: Text(
                    'Timetable',
                    style: TextStyle(fontSize: 17),
                  ),
                  leading: Icon(Icons.calendar_today),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeTableBody(),
                        ));
                  },
                ),
                ListTile(
                    leading: Icon(Icons.insert_chart),
                    onTap: () async {
                      // await DatabaseService()
                      //     .addTimetableData('PLC', '10-3-6', 5, 5);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Attendance(),
                          ));
                    },
                    title: Text(
                      'Attendance',
                      style: TextStyle(fontSize: 17),
                    )),
              ],
            ),
          ),
          // This container holds the align
          Container(
              // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      Divider(
                        thickness: 2,
                      ),
                      ListTile(
                        title: Text(
                          'Settings',
                          style: TextStyle(fontSize: 17),
                        ),
                        leading: Icon(Icons.settings),
                        onTap: () => showSettingsPanel(),
                      ),
                      ListTile(
                          leading: Icon(Icons.exit_to_app),
                          onTap: () async {
                            await _auth.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Wrapper(),
                                ));
                          },
                          title: Text(
                            'Logout',
                            style: TextStyle(fontSize: 17),
                          )),
                    ],
                  ))))
        ],
      ),
    );
  }
}
