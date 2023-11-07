// import 'package:medtest/activeOrder.dart';
// import 'package:medtest/design_course/home_design_course.dart';
// import 'package:medtest/history.dart';
// import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/model/patientInfo.dart';
// import 'package:medtest/profile.dart';
import 'package:medtest/report.dart';
import 'package:medtest/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class Wrapper3 extends StatelessWidget {
  const Wrapper3({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<UserOrderData>>.value(
        value: DatabaseService(uid: user.uid).orderData,
        initialData: [],
        child: LabReport());
  }
}
