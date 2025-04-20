import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String? title;
  String? body;
  int? status;
  DateTime? createdAt;

  TaskModel({this.id, this.body, this.title, this.status, this.createdAt});

  factory TaskModel.fromJson(DocumentSnapshot ss) {
    return TaskModel(
      id: ss['id'],
      title: ss['title'],
      body: ss['body'],
      status: ss['status'],
      createdAt: ss['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
