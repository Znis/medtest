// import 'package:medtest/design_course/home_design_course.dart';
// import 'package:medtest/main.dart';
import 'package:medtest/services/auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'medtest/medtest_app_theme.dart';
import 'login.dart';

class LogoutSuccess extends StatefulWidget {
  LogoutSuccess({Key? key}) : super(key: key);

  @override
  State<LogoutSuccess> createState() => _LogoutSuccessState();
}

class _LogoutSuccessState extends State<LogoutSuccess> {
  final AuthService _auth = AuthService();

  Future? futureJob;

  dynamic _futureFunc() async {
    return await _auth.signOut();
  }

  @override
  void initState() {
    // assign this variable your Future
    futureJob = _futureFunc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: futureJob,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen(
              register: false,
            );
          }

          return Scaffold(
            body: Center(
                child: Text(
              'Logging Out ...',
              style:
                  TextStyle(color: DesignCourseAppTheme.darkText, fontSize: 16),
            )),
          );
        });
  }
}
