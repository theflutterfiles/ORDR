class Event {
  String title;
  DateTime startDate;
  DateTime endDate;

  Event({this.title, this.startDate, this.endDate});

  Event.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    startDate = data['startDate'].toDate();
    endDate = data['endDate'].toDate() ?? null;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
      };
}
