// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String username;
  String password;
  String email;
  UserType type;
  List<String> searchHistory;
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.type,
    required this.searchHistory,
  });
}

enum UserType {
  admin,
  client,
}
