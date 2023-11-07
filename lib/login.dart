import 'package:medtest/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:medtest/medtest/home_medtest.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  final bool register;
  LoginScreen({required this.register});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  Duration get loginTime => Duration(milliseconds: 1800);

  Future<String?> _authUser(LoginData data) async {
    // dynamic result1 = await _auth.signInAnon();
    dynamic result =
        await _auth.signIn(data.name.toString(), data.password.toString());

    return Future.delayed(loginTime).then((_) {
      if (result == null) {
        return 'User not exists';
      } else if (result == '') {
        return 'Password does not match';
      }
    });
  }

  Future<String?> _signupUser(SignupData data) async {
    if (data.password.toString().length < 6) {
      return Future.delayed(loginTime).then((_) {
        return 'Password Must Be Six or More Characters Long!';
      });
    } else {
      dynamic result =
          await _auth.register(data.name.toString(), data.password.toString());

      return Future.delayed(loginTime).then((_) {
        if (result == null) {
          return 'Error Ocurred!';
        }
      });
    }
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      return 'Not Supported Yet';
      // }
    });
  }

  Future<bool> _onWillPopFn() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopFn,
      child: FlutterLogin(
        initialAuthMode: widget.register ? AuthMode.signup : AuthMode.login,
        title: 'MedTest',
        theme: LoginTheme(
          pageColorLight: Color(0xffF7EBE1),
          primaryColor: Color(0xFF17262A),
          accentColor: Color(0xffF7EBE1),
          errorColor: Colors.deepOrange,
          titleStyle: TextStyle(
            color: Color(0xFF17262A),
            fontFamily: 'Quicksand',
            letterSpacing: 2,
          ),
          buttonTheme: LoginButtonTheme(
            splashColor: Color(0xffF7EBE1),
            backgroundColor: Color(0xFF17262A),
            highlightColor: Color(0xFF17262A),
            elevation: 9.0,
            highlightElevation: 6.0,
          ),
        ),
        logo: AssetImage('assets/images/vectorimg.png'),
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => DesignCourseHomeScreen(),
          ));
        },
        onRecoverPassword: _recoverPassword,
      ),
    );
  }
}
