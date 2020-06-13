import 'package:firebase_tutorial/AuthManagement.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Login'),
          onPressed: () async {
            await signInWithGoogle().then((value) {
              Navigator.of(context).pushReplacementNamed('home');
            }).catchError((e) {
              print(e);
            });
          },
        ),
      ),
    );
  }
}
