class userModel {
  String? name;
  String? email;
  String? image;
  String? id;

  userModel(
      {required this.email,
      required this.id,
      required this.image,
      required this.name});

  userModel.fromJcon({required Map<String, dynamic> data}) {
    name = data['name'];
    email = data['email'];
    image = data['imageurl'];
    id = data['userid'];
  }

  Map<String, dynamic> toJcon() {
    return {
      'name': name,
      'email': email,
      'imageurl': image,
      'userid': id,
    };
  }
}
