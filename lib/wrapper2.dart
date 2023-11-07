import 'package:medtest/activeOrder.dart';
// import 'package:medtest/design_course/home_design_course.dart';
import 'package:medtest/history.dart';
// import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/model/patientInfo.dart';
// import 'package:medtest/profile.dart';
import 'package:medtest/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class Wrapper2 extends StatelessWidget {
  final int? indx;
  const Wrapper2({super.key, this.indx});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<List<UserOrderData>>.value(
        value: DatabaseService(uid: user.uid).orderData,
        initialData: [],
        child: indx == 0 ? ActiveOrder() : History());
  }
}
