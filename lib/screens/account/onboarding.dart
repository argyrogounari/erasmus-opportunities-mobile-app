

import 'package:erasmusopportunitiesapp/onboarding/flutter_login.dart';
import 'package:erasmusopportunitiesapp/onboarding/models/login_data.dart';
import 'package:erasmusopportunitiesapp/onboarding/models/signup_data.dart';
import 'package:erasmusopportunitiesapp/screens/account/account.dart';
import 'package:erasmusopportunitiesapp/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  final AuthService _auth = AuthService();

  Future<String> _signInUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.signInWithEmailAndPassword(data.email, data.password);
      if (user == null) {
        return 'Error signing in';
      }

      return null;
    });
  }

  Future<String> _signUpUser(SignUpData data) async {
    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.registerWithEmailAndPassword(data.email, data.password);
      if (user == null) {
        return 'Error signing up';
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {

      //TODO

      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo_white.png', scale: AppBar().preferredSize.height / 8,),
      ),
      body: FlutterLogin(
        onLogin: _signInUser,
        onSignup: _signUpUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Account(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}