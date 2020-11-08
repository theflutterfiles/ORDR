class Checklist {
  String id;
  String title;
  bool checked;

  Checklist({this.id, this.checked, this.title});

  Checklist.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    checked = data['checked'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'checked': checked,
      };
}
