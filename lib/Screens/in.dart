import 'package:flutter/material.dart';
import 'package:time_capsule/Service/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign in to Time Capusle'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val){
                        setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Password must have at least 6 characters' : null,
                      onChanged: (val){
                        setState(() => password = val);
                    }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.black,
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                          if(result == null){
                           setState(() => error = 'Could not sign in with those credentials');
                          }
                        }
                      }
                  ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                ]
              )
            )
        ),
    );
  }
}
