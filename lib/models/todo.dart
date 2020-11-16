import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel{
  String todoId;
  String content;
  bool done;

  ToDoModel({this.todoId, this.done, this.content});

  ToDoModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}){
    todoId = documentSnapshot.id;
    content = documentSnapshot.data()['content'] as String;
    done = documentSnapshot.data()['done'] as bool;
  }
}