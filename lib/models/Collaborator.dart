class Collaborator {
  String name;
  String number;
  String email;
  String instagram;

  Collaborator({this.number, this.email, this.instagram, this.name});

  Collaborator.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    number = data['number'];
    email = data['email'];
    instagram = data['instagram'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'email': email,
        'instagram': instagram,
      };
}
