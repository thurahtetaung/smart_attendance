import 'package:flutter/material.dart';
import 'package:smart_attendance/shared/constants.dart';

class Attendance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideDrawer(),
      backgroundColor: kPrimaryLightColor[200],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Smart Attendance'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Text('Attendance'),
      ),
    );
  }
}
