import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/database.dart';

class ToDoCard extends StatefulWidget {
  final ToDoModel todo;
  final FirebaseFirestore firestore;
  final String uid;
  ToDoCard({Key key, this.todo, this.firestore, this.uid}) : super(key: key);
  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.todo.content,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Checkbox(
              value: widget.todo.done,
              onChanged: (newValue) {
                setState(() {
                  Database(firestore: widget.firestore).updateTodo(
                    uid: widget.uid,
                    todoId: widget.todo.todoId,
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
