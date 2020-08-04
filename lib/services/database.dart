import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_attendance/models/brew.dart';
import 'package:smart_attendance/models/timetable_model.dart';
import 'package:smart_attendance/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  final CollectionReference studentCollection =
      Firestore.instance.collection('students');

  final Query timetableQuery = Firestore.instance
      .collection('timetables')
      .orderBy('Period', descending: false);

  final CollectionReference timetableCollection =
      Firestore.instance.collection('timetables');

  Future updateUserData({String name, String major, int roll, int year}) async {
    return await studentCollection.document(uid).setData({
      'name': name,
      'major': major,
      'roll': roll,
      'year': year,
    });
  }

  Future addTimetableData(
      String subject, String room, int period, int year) async {
    return await timetableCollection.document().setData({
      'Subject': subject,
      'Room': room,
      'Period': period,
      'Year': year,
    });
  }

  // timetable list from snapshot
  List<TimeTable> _timetableListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return TimeTable(
          subject: doc.data['Subject'] ?? '',
          period: doc.data['Period'] ?? 0,
          room: doc.data['Room'] ?? '',
          year: doc.data['Year'] ?? 0,
          day: doc.data['Day'] ?? 0);
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

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<List<TimeTable>> get timetables {
    return timetableCollection.snapshots().map(_timetableListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
