import 'package:charg_ev/constants.dart';
import 'package:charg_ev/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key, this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        appBar: AppBar(title: Text('Sign in'), actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register', style: TextStyle(color: Colors.white)))
        ]),
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
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) =>
                            val.isEmpty ? 'Password cannot be empty' : null,
                        onChanged: (value) {
                          setState(() => password = value);
                        },
                      ),
                      ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  //validation
                                  if (_formKey.currentState.validate()) {
                                    setState(() => isLoading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email: email, password: password);
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            'Could not sign in with those credentials';
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Text('Sign in')),
                      Text(error,
                          style: TextStyle(color: Colors.red, fontSize: 14))
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            setState(() => isLoading = true);
                            dynamic result = await _auth.signInAnon();
                            //print(result);
                          },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text('Sign in Anonymously')),
              ],
            )));
  }
}
