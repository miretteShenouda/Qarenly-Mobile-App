// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String username;
  String password;
  String email;
  UserType type;
  List<String> searchHistory;
  List<String> savedItems;
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.type,
    required this.searchHistory,
    required this.savedItems,

  });
}

enum UserType {
  admin,
  client,
}
