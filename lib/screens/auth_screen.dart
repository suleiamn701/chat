import 'package:chat/widgets/auth/auth_form1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool _isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authresults;

    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        authresults = await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
      } else {
        authresults = await _auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim());

        FirebaseFirestore.instance
            .collection('users')
            .doc(authresults.user?.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, Please check your passed data';
      if (err.message != null) {
        message = err.message!;
      }
      // Scaffold.of(context).showSnackBar(snackbar(
      //   content: Text(message),
      //   backgroundColor: Theme.of(context).errorColor,
      // ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.pink,
      body: AuthForm(_submitAuthForm),
    );
  }
}
