import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home.dart';
import '../const.dart';
import '../httpclient/authHttp.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
//
// const users = const {
//   'naschenweng.works@gmail.com': '12345',
//   't@gmail.com': '123',
// };

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _authUser(LoginData data) async {
    //print('Name: ${data.name}, Password: ${data.password}');

    var autHttp = AuthHttp();
    String strError = "";

    String strPerson = await autHttp.getPerson(data.name).onError((error, stackTrace) {
      print(error.toString());
      print(stackTrace.toString());

      if (error.toString().indexOf("404")>0){
        strError = AppLocalizations
            .of(context)
            .usernameNotExists;
      } else {
        strError = error.toString();
      }
      return strError;

    }
    );

    if  (strError == "") {
      Map<String, dynamic> person = jsonDecode(strPerson);

      if (person['login'] == "") {
        return AppLocalizations
            .of(context)
            .usernameNotExists;
      }
      if (person['password'] != data.password) {
        return AppLocalizations
            .of(context)
            .passwordDoesNotMatch;
      }

      return null;
    } else {
      return strError;
    }


  }

  // Future<String> _authUser(LoginData data) {
  //   print('Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(data.name)) {
  //       return AppLocalizations.of(context).usernameNotExists;
  //     }
  //     if (users[data.name] != data.password) {
  //       return AppLocalizations.of(context).passwordDoesNotMatch;
  //     }
  //
  //     return null;
  //   });
  // }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'Username not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Const.titleApp,
      logo: 'images/logo.png',
      onLogin: _authUser,
      onSignup: _authUser,
      // loginProviders: <LoginProvider> [LoginProvider(
      //   icon: FontAwesomeIcons.google,
      //   callback: () async {
      //     print('start google sign in');
      //     await Future.delayed(loginTime);
      //     print('stop google sign in');
      //     return null;
      //   },
      // ),
      // ],
      messages: LoginMessages(
        usernameHint: AppLocalizations.of(context).usernameHint,
        passwordHint: AppLocalizations.of(context).passwordHint,
        confirmPasswordHint: AppLocalizations.of(context).confirmPasswordHint,
        forgotPasswordButton: AppLocalizations.of(context).forgotPasswordButton,
        loginButton: AppLocalizations.of(context).loginButton,
        signupButton: AppLocalizations.of(context).signupButton,
        recoverPasswordButton:
            AppLocalizations.of(context).recoverPasswordButton,
        recoverPasswordIntro: AppLocalizations.of(context).recoverPasswordIntro,
        recoverPasswordDescription:
            AppLocalizations.of(context).recoverPasswordDescription,
        goBackButton: AppLocalizations.of(context).goBackButton,
        confirmPasswordError: AppLocalizations.of(context).confirmPasswordError,
        recoverPasswordSuccess:
            AppLocalizations.of(context).recoverPasswordSuccess,
        flushbarTitleError: AppLocalizations.of(context).flushbarTitleError,
        flushbarTitleSuccess: AppLocalizations.of(context).flushbarTitleSuccess,
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
