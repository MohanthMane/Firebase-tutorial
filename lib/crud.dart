import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Create
addTodo(todo) async {
  await Firestore.instance.collection('todos').add(todo).then((value) {
    Fluttertoast.showToast(msg: 'Successfully added');
  }).catchError((e) {
    Fluttertoast.showToast(msg: 'Error occured');
  });
}

// Read
readTodos() {
  return Firestore.instance.collection('todos').snapshots(); // STREAM
}

// Update
updateTodo(docId, newTodo) async {
  await Firestore.instance
      .collection('todos')
      .document(docId)
      .updateData(newTodo)
      .then((value) {
    Fluttertoast.showToast(msg: 'Updated successfully');
  }).catchError((e) {
    Fluttertoast.showToast(msg: 'Error updating');
  });
}

// Delete
deleteTodo(docId) async {
  await Firestore.instance
      .collection('todos')
      .document(docId)
      .delete()
      .then((value) {
    Fluttertoast.showToast(msg: 'Deleted successfully');
  }).catchError((e) {
    Fluttertoast.showToast(msg: 'Error deleting todo');
  });
}
