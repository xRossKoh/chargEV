import 'package:charg_ev/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:charg_ev/constants.dart';

class Register extends StatefulWidget {
  const Register({Key key, this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Register'),
          actions: [
            TextButton.icon(
                onPressed: () {
                  widget.toggleView();
                },
                icon: Icon(Icons.person),
                label: Text('Sign In', style: TextStyle(color: Colors.white)))
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: businessLogo,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (value) =>
                            value.isEmpty ? 'Please enter an email' : null,
                        onChanged: (value) {
                          setState(() => email = value.trim());
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (value) => value.length < 6
                            ? 'Password must be longer than 6 characters'
                            : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => isLoading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email: email, password: password);
                                    setState(() => isLoading = false);
                                    if (result == null) {
                                      setState(() {
                                        error = 'Please supply a valid email';
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text('Register')),
                      Text(
                        error,
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
