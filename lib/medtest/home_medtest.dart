import 'package:medtest/medtest/add_todo_button.dart';
import 'package:medtest/medtest/category_list_view.dart';
import 'package:medtest/medtest/test_info_screen.dart';
import 'package:medtest/medtest/popular_test_list_view.dart';
// import 'package:medtest/history.dart';
// import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/login.dart';
import 'package:medtest/profile.dart';
// import 'package:medtest/report.dart';
// import 'package:medtest/services/auth.dart';
import 'package:medtest/wrapper3.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:medtest/wrapper2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:medtest/activeOrder.dart';
// import 'package:medtest/design_course/home_design_course.dart';
// import 'package:medtest/history.dart';
// import 'package:medtest/introduction_animation/introduction_animation_screen.dart';
// import 'package:medtest/model/patientInfo.dart';
// import 'package:medtest/profile.dart';
// import 'package:medtest/services/database.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:medtest/model/patientInfo.dart';
// import 'package:provider/provider.dart';
// import 'package:medtest/services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../model/user.dart' as modelUser;

import 'medtest_app_theme.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';
import 'package:medtest/main.dart';

class DesignCourseHomeScreen extends StatefulWidget {
  final history;
  const DesignCourseHomeScreen({super.key, this.history});
  @override
  _DesignCourseHomeScreenState createState() => _DesignCourseHomeScreenState();
}

class _DesignCourseHomeScreenState extends State<DesignCourseHomeScreen>
    with TickerProviderStateMixin {
  CategoryType categoryType = CategoryType.basics;
  // final AuthService _auth = AuthService();
  String name = 'Guest';
  String goodText = '';
  String ppUrl = 'assets/testimages/userImage.png';

  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
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
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    goodText = DateFormat('hh:mm a').format(DateTime.now()).toString();
    goodText.substring(goodText.length - 2) == 'PM'
        ? goodText = 'Good Afternoon!'
        : goodText = 'Good Morning!';

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        name = 'Guest';
      } else {
        String email = user.email!;
        RegExp exp = new RegExp(
          r"[^a-zA-Z]",
          caseSensitive: false,
          multiLine: false,
        );
        name = email
            .substring(0, email.indexOf('@'))
            .replaceAll(exp, '')
            .toString();
        name = name[0].toUpperCase() + name.substring(1).toLowerCase();
      }
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: DesignCourseAppTheme.nearlyWhite,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                getAppBarUI(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          getLabReportButtonUI('Lab Report'),
                          // getSearchBarUI(),
                          getCategoryUI(),
                          Flexible(
                            child: getPopularCourseUI(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: ScaleTransition(
              alignment: Alignment.center,
              scale: CurvedAnimation(
                  parent: animationController!, curve: Curves.fastOutSlowIn),
              child: Card(
                color: DesignCourseAppTheme.nearlyBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                elevation: 10.0,
                child: Container(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {});
                        Navigator.of(context)
                            .push(HeroDialogRoute(builder: (context) {
                          return AddTodoPopupCard(callBack: (int a) {
                            setState(() {});
                          });
                        }));
                      },
                      child: Hero(
                        tag: heroAddTodo,
                        createRectTween: (begin, end) {
                          return CustomRectTween(begin: begin!, end: end!);
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Material(
                              color: Colors.blue,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Center(
                                child: const Icon(Icons.shopping_cart_outlined,
                                    color: Colors.white, size: 36),
                              ),
                            ),
                            cartItemCount > 0
                                ? Material(
                                    color: Colors.red[400],
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        cartItemCount.toString(),
                                        style: TextStyle(
                                            color: DesignCourseAppTheme
                                                .nearlyWhite),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Tests Category',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(
                  CategoryType.basics, categoryType == CategoryType.basics),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.blood, categoryType == CategoryType.blood),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.hormone, categoryType == CategoryType.hormone),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
          displayCategory: categoryType,
          callBack: (int indx, bool moveToOrNot) {
            setState(() {});

            moveToOrNot ? moveTo(indx) : moveToOrNot = moveToOrNot;
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Available Services',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Flexible(
            child: PopularCourseListView(
              callBack: (int indx) {
                moveTo(indx);
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo(int indx) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseInfoScreen(indexnum: indx),
      ),
    );
    setState(() {});
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.basics == categoryTypeData) {
      txt = 'Basics';
    } else if (CategoryType.blood == categoryTypeData) {
      txt = 'Blood';
    } else if (CategoryType.hormone == categoryTypeData) {
      txt = 'Hormone';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLabReportButtonUI(String btnLabel) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
        width: 150,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: DesignCourseAppTheme.nearlyBlue,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wrapper3()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 18, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    btnLabel,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      letterSpacing: 0.32,
                      color: DesignCourseAppTheme.nearlyWhite,
                    ),
                  ),
                  Icon(
                    Icons.file_copy_outlined,
                    color: DesignCourseAppTheme.nearlyWhite,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Widget getSearchBarUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, left: 18),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.75,
  //           height: 64,
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 8, bottom: 8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: HexColor('#F8FAFB'),
  //                 borderRadius: const BorderRadius.only(
  //                   bottomRight: Radius.circular(13.0),
  //                   bottomLeft: Radius.circular(13.0),
  //                   topLeft: Radius.circular(13.0),
  //                   topRight: Radius.circular(13.0),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Container(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: TextFormField(
  //                         style: TextStyle(
  //                           fontFamily: 'WorkSans',
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                           color: DesignCourseAppTheme.nearlyBlue,
  //                         ),
  //                         keyboardType: TextInputType.text,
  //                         decoration: InputDecoration(
  //                           labelText: 'Search for course',
  //                           border: InputBorder.none,
  //                           helperStyle: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 16,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                           labelStyle: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 16,
  //                             letterSpacing: 0.2,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                         ),
  //                         onEditingComplete: () {},
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 60,
  //                     height: 60,
  //                     child: Icon(Icons.search, color: HexColor('#B9BABC')),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         const Expanded(
  //           child: SizedBox(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  goodText,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // await _auth.signOut();
              Navigator.push(
                _scaffoldKey.currentContext!,
                MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          name: name,
                        )),
              );
            },
            child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: DesignCourseAppTheme.lightText,
                    width: 1.4,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(22),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(0.5),
                  child: Image.asset(ppUrl),
                )),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  basics,
  blood,
  hormone,
}
