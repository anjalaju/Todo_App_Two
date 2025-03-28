import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? password;
  String? name;
  String? uid;
  DateTime? createdAt;
  int? status;

  UserModel({
    this.email,
    this.password,
    this.name,
    this.uid,
    this.createdAt,
    this.status,
  });

  factory UserModel.fromJson(DocumentSnapshot data) {
    return UserModel(
      email: data['email'],
      uid: data['uid'],
      name: data['name'],
      status: data['status'],
      createdAt: data['createdAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "password": password,
      "status": status,
      "email": email,
      "createdAt": createdAt,
    };
  }
}
