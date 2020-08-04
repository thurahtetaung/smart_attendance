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
  final String email;

  UserData2({
    this.uid,
    this.name,
    this.year,
    this.email,
    this.major,
    this.rollNumber,
  });
}
