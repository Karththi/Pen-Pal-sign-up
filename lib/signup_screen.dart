import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import './signup_form.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitSignUpForm(
      String email, String password, BuildContext context) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user.uid)
          .set({'Email Address': email, 'Password': password});
    } on PlatformException catch (err) {
      var msg = 'An error occured, please check your credentials';

      if (err.message != null) {
        msg = err.message;
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SignUpForm(_submitSignUpForm, _isLoading),
    );
  }
}
