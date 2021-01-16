class TimeTable {
  final String subject;
  dynamic period;
  final String major;
  final String room;
  final int year;
  final int day;

  TimeTable(
      {this.subject, this.period, this.room, this.year, this.day, this.major});

  void editPeriod(dynamic period) {
    this.period = '$period,${period + 1}';
  }
}

class Calendar {
  final String subject;
  final int year;
  final String major;
  final List<int> count;

  Calendar({this.subject, this.year, this.major, this.count});
}
