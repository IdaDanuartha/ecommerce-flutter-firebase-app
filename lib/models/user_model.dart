class UserModel {
  late String id;
  late String name;
  late String username;
  late String email;
  late String profilePath;
  late String role;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profilePath,
    required this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    username = json["username"];
    email = json["email"];
    profilePath = json["profile_path"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "username": username,
      "email": email,
      "profile_path": profilePath,
      "role": role,
    };
  }
}