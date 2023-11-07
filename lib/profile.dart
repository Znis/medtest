// import 'package:medtest/activeOrder.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
// import 'package:medtest/login.dart';
import 'package:medtest/logoutSuccess.dart';
// import 'package:medtest/model/patientInfo.dart';
// import 'package:medtest/services/auth.dart';
// import 'package:medtest/services/database.dart';
// import 'package:medtest/wrapper.dart';
import 'package:medtest/wrapper2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final history;
  final name;
  const ProfilePage({super.key, this.history, required this.name});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // final AuthService _auth = AuthService();

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        title: Text(
          'Profile',
          style: TextStyle(color: DesignCourseAppTheme.lightText, fontSize: 24),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  height: size.height / 5,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    boxShadow: [
                      BoxShadow(
                          color: DesignCourseAppTheme.notWhite,
                          blurRadius: 2,
                          spreadRadius: 2,
                          blurStyle: BlurStyle.normal)
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70)),
                  ),
                  child: Image.asset('assets/images/coverpp.jpg'),
                ),
                SizedBox(height: 100),
              ],
            ),
            Positioned(
                left: size.width / 2.5,
                top: size.height / 6.75,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/testimages/userImage.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: DesignCourseAppTheme.lightText, fontSize: 16),
                    ),
                  ],
                ))
          ]),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      _scaffoldkey.currentContext!,
                      MaterialPageRoute(
                          builder: (context) => Wrapper2(indx: 0)),
                    );
                  },
                  child: Card(
                    shadowColor: DesignCourseAppTheme.notWhite,
                    margin: EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 10),
                    child: ListTile(
                      leading: Icon(Icons.access_time),
                      title: Text('Active Order'),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      _scaffoldkey.currentContext!,
                      MaterialPageRoute(
                          builder: (context) => Wrapper2(indx: 1)),
                    );
                  },
                  child: Card(
                    shadowColor: DesignCourseAppTheme.notWhite,
                    margin: EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 10),
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('History'),
                    ),
                  ),
                ),
                Card(
                  shadowColor: DesignCourseAppTheme.notWhite,
                  margin: EdgeInsets.only(
                      top: 0.0, left: 20.0, right: 20.0, bottom: 10),
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogoutSuccess()),
                    );
                  },
                  child: Card(
                    shadowColor: DesignCourseAppTheme.notWhite,
                    margin: EdgeInsets.only(
                        top: 0.0, left: 20.0, right: 20.0, bottom: 10),
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
