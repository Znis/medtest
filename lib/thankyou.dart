import 'package:medtest/medtest/home_medtest.dart';
import 'package:medtest/main.dart';
import 'package:flutter/material.dart';
import 'medtest/medtest_app_theme.dart';

class ThankyouPage extends StatefulWidget {
  final data;
  ThankyouPage({Key? key, required this.data}) : super(key: key);

  @override
  State<ThankyouPage> createState() => _ThankyouPageState();
}

class _ThankyouPageState extends State<ThankyouPage> {
  dynamic submitData() async {
    await widget.data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: submitData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                body: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tests Booked Successfully',
                      style: TextStyle(
                          color: DesignCourseAppTheme.darkText, fontSize: 16),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        for (int i = 0; i < lenOfItems; i++) {
                          cartItemsList[i] = false;
                        }
                        cartItemCount = 0;

                        await await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DesignCourseHomeScreen()),
                        );
                      },
                      child: Container(
                        height: 48,
                        width: size.width / 1.5,
                        decoration: BoxDecoration(
                          color: DesignCourseAppTheme.nearlyBlue.withOpacity(1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: DesignCourseAppTheme.nearlyBlue
                                    .withOpacity(0.4),
                                offset: const Offset(1.1, 1.1),
                                blurRadius: 10.0),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Done',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              letterSpacing: 0.0,
                              color: DesignCourseAppTheme.nearlyWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            );
          }
          return Scaffold(
              body: Center(
                  child: Text(
            'Placing Order ...',
            style:
                TextStyle(color: DesignCourseAppTheme.darkText, fontSize: 16),
          )));
        });
  }
}
