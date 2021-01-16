import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/models/brew.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class DatabaseService {
  final String uid;
  final String major;
  final int year;
  final int period;
  final String subject;
  final int day;
  DatabaseService(
      {this.uid, this.major, this.period, this.year, this.subject, this.day});

  // collection reference

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  final CollectionReference studentCollection =
      Firestore.instance.collection('students');

  final Query timetableQuery =
      Firestore.instance.collection('timetables').orderBy('Period');

  final CollectionReference timetableCollection =
      Firestore.instance.collection('timetables');

  final Query calendarCollection =
      Firestore.instance.collection('calendar2020');

  Future updateUserData({String name, String major, int roll, int year}) async {
    return await studentCollection.document(uid).setData({
      'name': name,
      'major': major,
      'roll': roll,
      'year': year,
    });
  }

  Future setDailyAttendance() async {
    return await studentCollection
        .document(uid)
        .collection('daily_attendance')
        .document('2020')
        .setData({
      '1': false,
      '2': false,
      '3': false,
      '4': false,
      '5': false,
      '6': false,
      '7': false,
      '8': false,
      '9': false,
      '10': false,
    });
  }

  Future<List<TimeTable>> getTimetableList() async {
    QuerySnapshot timetableData = await Firestore.instance
        .collection('timetables')
        .where('Major', isEqualTo: major)
        .where('Year', isEqualTo: year)
        .getDocuments();
    return timetableData.documents
        .map((doc) => TimeTable(
              subject: doc.data['Subject'],
              period: doc.data['Period'],
              room: doc.data['Room'],
              year: doc.data['Year'],
              day: doc.data['Day'],
              major: doc.data['Major'],
            ))
        .toList();
  }

  Future setMonthlyAttendanceBySubject(String subjectName) async {
    return await studentCollection
        .document(uid)
        .collection('monthly_attendance_2020')
        .document(subjectName)
        .setData({
      'January': 0,
      'February': 0,
      'March': 0,
      'April': 0,
      'May': 0,
      'June': 0,
      'July': 0,
      'August': 0,
      'September': 0,
      'October': 0,
      'November': 0,
      'December': 0,
    });
  }

  Future setAttendanceForUser() async {
    List<TimeTable> tt = await getTimetableList();
    for (var i = 0; i < tt.length; i++) {
      if (tt[i].subject != 'Lunch Break') {
        setMonthlyAttendanceBySubject(tt[i].subject);
      }
    }
  }

  Future updateDailyAttendance({int index}) async {
    return await studentCollection
        .document(uid)
        .collection('daily_attendance')
        .document('2020')
        .updateData({
      '$index': true,
    });
  }

  Future addTimetableData(
      {String subject,
      String room,
      int period,
      int year,
      String major,
      int day}) async {
    return await timetableCollection.document().setData({
      'Subject': subject,
      'Room': room,
      'Period': period,
      'Year': year,
      'Major': major,
      'Day': day
    });
  }

  // timetable list from snapshot
  List<TimeTable> timetableListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TimeTable(
        subject: doc.data['Subject'] ?? '',
        period: doc.data['Period'] ?? 0,
        room: doc.data['Room'] ?? '',
        year: doc.data['Year'] ?? 0,
        day: doc.data['Day'] ?? 0,
        major: doc.data['Major'] ?? '',
      );
    }).toList();
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  // timetableData from snapshot
  TimeTable timetableDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) {
          return TimeTable(
              major: doc.data['Major'],
              year: doc.data['Year'],
              subject: doc.data['Subject'],
              period: doc.data['Period'],
              room: doc.data['Room'],
              day: doc.data['Day']);
        })
        .toList()
        .first;
  }

  UserData2 _userData2FromSnapshot(DocumentSnapshot snapshot) {
    return UserData2(
      uid: uid,
      name: snapshot.data['name'] ?? '',
      year: snapshot.data['year'] ?? 0,
      major: snapshot.data['major'] ?? '',
      rollNumber: snapshot.data['roll'] ?? 0,
    );
  }

  List<Calendar> _calendarFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents
        .map((doc) => Calendar(
                subject: doc.documentID,
                major: doc.data['major'],
                year: doc.data['year'],
                count: [
                  doc.data['jan'],
                  doc.data['feb'],
                  doc.data['mar'],
                  doc.data['apr'],
                  doc.data['may'],
                  doc.data['jun'],
                  doc.data['jul'],
                  doc.data['aug'],
                  doc.data['sep'],
                  doc.data['oct'],
                  doc.data['nov'],
                  doc.data['dec'],
                ]))
        .toList();
  }

  List<AttendanceData> _attendanceFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return AttendanceData(
        uid: uid,
        subject: doc.documentID,
        attendance: [
          doc.data['January'],
          doc.data['February'],
          doc.data['March'],
          doc.data['April'],
          doc.data['May'],
          doc.data['June'],
          doc.data['July'],
          doc.data['August'],
          doc.data['September'],
          doc.data['October'],
          doc.data['November'],
          doc.data['December'],
        ],
      );
    }).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<List<TimeTable>> get timetables {
    return timetableQuery.snapshots().map(timetableListFromSnapshot);
  }

  Stream<List<TimeTable>> get daytimetables {
    return timetableQuery
        .where('Day', isEqualTo: day)
        .where('Major', isEqualTo: major)
        .where('Year', isEqualTo: year)
        .snapshots()
        .map(timetableListFromSnapshot);
  }

  Stream<List<AttendanceData>> get attendancedata {
    return studentCollection
        .document(uid)
        .collection('monthly_attendance_2020')
        .snapshots()
        .map(_attendanceFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<UserData2> get userData2 {
    if (uid != null) {
      return studentCollection
          .document(uid)
          .snapshots()
          .map(_userData2FromSnapshot);
    } else
      return studentCollection
          .document('test')
          .snapshots()
          .map(_userData2FromSnapshot);
  }

  Stream<DocumentSnapshot> get dailyAttendance {
    if (uid != null) {
      return studentCollection
          .document(uid)
          .collection('daily_attendance')
          .document('2020')
          .snapshots();
    } else
      return studentCollection
          .document('test')
          .collection('daily_attendance')
          .document('2020')
          .snapshots();
  }

  Stream<List<Calendar>> get calendarData {
    return calendarCollection.snapshots().map(_calendarFromSnapshot);
  }
}
