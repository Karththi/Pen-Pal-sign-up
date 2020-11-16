import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  final void Function(String email, String password, BuildContext context)
      submit;
  final bool isLoading;

  SignUpForm(this.submit, this.isLoading);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submit(_userEmail.trim(), _userPassword.trim(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Please enter a valid Email Address';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (newValue) {
                      _userEmail = newValue;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty || value.length < 7)
                        return 'Password must contain atleast 7 characters';
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (newValue) {
                      _userPassword = newValue;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading)
                    CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  if (!widget.isLoading)
                    RaisedButton(
                        child: Text(
                          'sign up',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        onPressed: _trySubmit),
                ],
              )),
        ),
      ),
    );
  }
}
