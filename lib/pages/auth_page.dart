import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'signin_form.dart';
import 'signup_form.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool signIn = false;


  Widget loginSwitcher() {
    return TextButton(
      onPressed: () {
        setState(() {
          signIn = !signIn;
        });
      },
      child: Text(
        signIn ? 'Create Account' : 'Signin to you account',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return signIn
            ? SignInForm(
                loginSwitcher: loginSwitcher(),
               
              )
            : SignUpForm(
                loginSwitcher: loginSwitcher(),
               
              );
  }
}
