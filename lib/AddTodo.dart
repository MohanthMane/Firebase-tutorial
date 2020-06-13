import 'package:firebase_tutorial/crud.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final formKey = new GlobalKey<FormState>();
  var todo, status;
  
  validateAndSave() {
    final form = formKey.currentState;
    
    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  validateAndSubmit() async {
    if(validateAndSave()) {
      await addTodo({'todo': this.todo, 'status': this.status});
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add todo'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Todo'),
              onSaved: (value) => todo = value,
              validator: (value) {
                return value.isEmpty ? 'Field is required' : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Status'),
              onSaved: (value) => status = value,
              validator: (value) {
                return value.isEmpty ? 'Field is required' : null;
              },
            ),
            RaisedButton(
              child: Text('Add'),
              onPressed: () async {
                await validateAndSubmit();
              },
            )
          ],
        ),
      ),
    );
  }
}
