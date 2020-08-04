import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_attendance/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor[200],
      child: Center(
        child: SpinKitChasingDots(
          color: kPrimaryColor,
          size: 50,
        ),
      ),
    );
  }
}
