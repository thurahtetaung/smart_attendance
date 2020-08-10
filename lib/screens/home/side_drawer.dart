import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/models/user.dart';
import 'package:smart_attendance/screens/attendance/attendance_screen.dart';
import 'package:smart_attendance/screens/home/home.dart';
import 'package:smart_attendance/screens/home/settings_form.dart';
import 'package:smart_attendance/screens/timetable/timetable_screen.dart';
import 'package:smart_attendance/services/auth.dart';
import 'package:smart_attendance/services/database.dart';
import 'package:smart_attendance/shared/constants.dart';
import '../wrapper.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
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

    final user = Provider.of<User>(context) ?? User(uid: null);

    return StreamBuilder<UserData2>(
        stream: DatabaseService(uid: user.uid).userData2,
        builder: (context, snapshot) {
          UserData2 userData2 = snapshot.data;

          if (userData2 == null) {
            userData2 = UserData2(
                uid: '0', name: 'test', major: 'test', year: 0, rollNumber: 0);
          }

          return Drawer(
            // column holds all the widgets in the drawer
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Name - ${userData2.name}'),
                      Text('Major - ${userData2.major}'),
                      Text('Year - ${userData2.year}'),
                      Text('RollNo - ${userData2.rollNumber}'),
                    ],
                  ),
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
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
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
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => TimeTableBody(),
                              ));
                        },
                      ),
                      ListTile(
                          leading: Icon(Icons.insert_chart),
                          onTap: () async {
                            // await DatabaseService()
                            //     .addTimetableData('PLC', '10-3-6', 5, 5);
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
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
                                      CupertinoPageRoute(
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
        });
  }
}
