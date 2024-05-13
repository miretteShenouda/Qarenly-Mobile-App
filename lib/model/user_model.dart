// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String id;
  String username;
  String password;
  String email;
  UserType type;
  List<String>? searchHistory;
  List<String>? savedItems;
  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.type = UserType.client,
    this.searchHistory,
    this.savedItems,
  });
}

enum UserType {
  admin,
  client,
}
