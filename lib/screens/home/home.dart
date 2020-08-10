import 'package:flutter/material.dart';
import 'package:smart_attendance/models/brew.dart';
import 'package:smart_attendance/screens/home/brew_list.dart';
import 'package:smart_attendance/screens/home/side_drawer.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendance/services/auth.dart';
import 'package:smart_attendance/services/database.dart';
import 'package:smart_attendance/shared/constants.dart';

class Home extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
        drawer: SideDrawer(),
        backgroundColor: kPrimaryLightColor[200],
        appBar: AppBar(
          title: Text('Smart Attendance'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage('assets/coffee_bg.png'),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: BrewList(),
        ),
      ),
    );
  }
}
