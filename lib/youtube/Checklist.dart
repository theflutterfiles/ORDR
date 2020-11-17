class Checklist {
 
  String title;
  bool checked;

  Checklist({this.checked, this.title});

  Checklist.fromMap(Map<String, dynamic> data) {
    title = data['title'];
    checked = data['checked'];
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'checked': checked,
      };

  
}
