import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class HomePage extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  HomePage({Key key, @required this.auth, @required this.firestore})
      : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'ToDo',
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              Auth(auth: widget.auth).signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              "Add your Task here:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: ValueKey('addField'),
                      controller: _todoController,
                    ),
                  ),
                  IconButton(
                    key: ValueKey("addButton"),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (_todoController.text != "") {
                        setState(() {
                          Database(firestore: widget.firestore).addToDo(
                            uid: widget.auth.currentUser.uid,
                            content: _todoController.text,
                          );
                          _todoController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Your Tasks:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Database(firestore: widget.firestore)
                  .streamTodos(uid: widget.auth.currentUser.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ToDoModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text(
                        "You don't have any unfinished tasks.",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ToDoCard(
                        firestore: widget.firestore,
                        uid: widget.auth.currentUser.uid,
                        todo: snapshot.data[index],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "Loading Tasks...",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
