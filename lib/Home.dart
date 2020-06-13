import 'package:firebase_tutorial/AddTodo.dart';
import 'package:firebase_tutorial/AuthManagement.dart';
import 'package:firebase_tutorial/crud.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await signOut().then((val) {
                Navigator.of(context).pushReplacementNamed('landing');
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: readTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  var todo = snapshot.data.documents[index].data;
                  var docID = snapshot.data.documents[index].documentID;
                  return ListTile(
                    title: Text(todo['todo']),
                    subtitle: Text(todo['status']),
                    onLongPress: () async {
                      await deleteTodo(docID);
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      height: 1.0,
                    ),
                itemCount: snapshot.data.documents.length);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
      ),
    );
  }
}
