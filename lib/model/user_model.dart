// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String username;
  String password;
  String email;
  UserType type;
  List<String>? searchHistory = List<String>.empty();
  List<DocumentReference>? savedItems;
  String? notificationToken = null;
  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    this.type = UserType.client,
    this.searchHistory,
    List<DocumentReference>? savedItems,
    this.notificationToken,
  }) : savedItems = savedItems ?? List<DocumentReference>.empty(growable: true);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'type': type.name,
      'searchHistory': searchHistory,
      'savedItems': savedItems,
      'notificationToken': notificationToken,
    };
  }
}

enum UserType {
  admin,
  client,
}
