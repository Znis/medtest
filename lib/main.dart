import 'dart:io';
import 'package:medtest/app_theme.dart';
// import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/design_course/home_design_course.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:medtest/patient_detail.dart';
import 'package:medtest/services/auth.dart';
// import 'package:medtest/thankyou.dart';
import 'package:medtest/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medtest/medtest/models/category.dart';
import 'package:provider/provider.dart';
// import 'location.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:medtest/model/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

int lenOfItems = Category.popularCourseList.length;

List<bool> cartItemsList = [];
int cartItemCount = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < lenOfItems; i++) {
      cartItemsList.add(false);
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<User>.value(
              value: AuthService().user,
              initialData: User(uid: ''),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  textTheme: AppTheme.textTheme,
                  platform: TargetPlatform.android,
                ),
                home: Wrapper(),
                //PatientDetail(),
                //IntroductionAnimationScreen(),
              ),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: AppTheme.textTheme,
              platform: TargetPlatform.android,
            ),
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.waveDots(
                      color: Colors.lightBlue,
                      size: 50,
                    ),
                    Text(
                      'Loading',
                      style: TextStyle(
                          fontSize: 16, color: DesignCourseAppTheme.darkText),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
