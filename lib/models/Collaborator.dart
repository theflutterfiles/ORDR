class Collaborator {
  String name;
  String number;
  String email;
  String instagramHandle;

  Collaborator(this.number, this.email, this.instagramHandle, {this.name});

  Collaborator.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    number = data['number'];
    email = data['email'];
    instagramHandle = data['instagramHandle'];
  }
}
