class UserModel {
  late String id;
  late String name;
  late String username;
  late String email;
  late String profileUrl;
  late String role;
  late String password;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileUrl,
    required this.role,
    required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    profileUrl = json["profile_url"];
    role = json["role"];
    password = json["password"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "profile_url": profileUrl,
      "role": role,
      "password": password,
    };
  }
}