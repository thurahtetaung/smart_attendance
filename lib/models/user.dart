class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.sugars, this.strength});
}

class UserData2 {
  final String uid;
  final String name;
  final int year;
  final String major;
  final int rollNumber;

  UserData2({
    this.uid,
    this.name,
    this.year,
    this.major,
    this.rollNumber,
  });
}

class AttendanceData {
  final String uid;
  final String subject;
  final int attendance;

  AttendanceData({this.uid, this.attendance, this.subject});
}
