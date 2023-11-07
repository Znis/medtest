import 'package:medtest/medtest/home_medtest.dart';
import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/model/patientInfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user.uid == '') {
      return IntroductionAnimationScreen();
    } else {
      return DesignCourseHomeScreen();
    }
  }
}
