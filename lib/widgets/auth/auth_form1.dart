import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // const AuthForm({Key? key}) : super(key: key);

  final void Function(
    String email,
    String password,
    String username,
    bool _isLogin,
    BuildContext ctx,
  ) submitFunction;

  AuthForm(this.submitFunction);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userName = '';
  var _email = '';
  var _password = '';
  bool _isLogin = true;

  void _trySubmitForm() {
    final isValid = _formKey.currentState?.validate();
    if (isValid!) {
      _formKey.currentState?.save();
      widget.submitFunction(
          _email.toString().trim(),
          _password.toString().trim(),
          _userName.toString().trim(),
          _isLogin,
          context);
    }

    print(_userName);
    print(_email);
    print(_password);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter  a user name with at lease 4 chars';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'User Name'),
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please enter  a password with at lease 7 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    onPressed: _trySubmitForm,
                    child: Text(_isLogin ? 'Login' : 'SignUp'),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create New Account'
                        : 'I already have an Account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
