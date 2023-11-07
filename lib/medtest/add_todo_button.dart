// import 'package:medtest/design_course/category_list_view.dart';
// import 'package:medtest/design_course/course_info_screen.dart';
// import 'package:medtest/design_course/home_design_course.dart';
// import 'package:medtest/design_course/popular_course_list_view.dart';
import 'package:medtest/patient_detail.dart';
import 'package:flutter/material.dart';
import 'package:medtest/app_theme.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:medtest/medtest/models/category.dart';
import 'package:medtest/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:medtest/location.dart';
import 'custom_rect_tween.dart';
import 'hero_dialog_route.dart';

class AddTodoButton extends StatefulWidget {
  const AddTodoButton({Key? key, this.callback}) : super(key: key);
  final Function(int)? callback;

  @override
  State<AddTodoButton> createState() => _AddTodoButtonState();
}

class _AddTodoButtonState extends State<AddTodoButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          widget.callback!(1);

          setState(() {});

          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return AddTodoPopupCard(callBack: (int b) {
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white, size: 36),
                ),
              ),
              cartItemCount > 0
                  ? Material(
                      color: Colors.red[400],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          cartItemCount.toString(),
                          style: TextStyle(
                              color: DesignCourseAppTheme.nearlyWhite),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

const String heroAddTodo = 'add-todo-hero';

class AddTodoPopupCard extends StatefulWidget {
  const AddTodoPopupCard({Key? key, this.callBack}) : super(key: key);
  final Function(int)? callBack;

  @override
  State<AddTodoPopupCard> createState() => _AddTodoPopupCardState();
}

class _AddTodoPopupCardState extends State<AddTodoPopupCard> {
  int totalAmt = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Center(
    //   child: GestureDetector(
    //     onTap: () {
    //       setState(() {});
    //       Navigator.of(context).push(HeroDialogRoute(builder: (context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 60.0, bottom: 50, left: 20, right: 20),
        child: Hero(
          tag: heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Container(
            width: double.infinity,
            height: size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              color: AppTheme.nearlyWhite,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Tests To Be Booked',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 0.2,
                      color: AppTheme.darkerText,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          cartItemCount > 0
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int i = 0; i < lenOfItems; i++)
                                      cartItemsList[i]
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              child: Container(
                                                height: 69,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: DesignCourseAppTheme
                                                      .chipBackground,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        16.0)),
                                                            child: AspectRatio(
                                                                aspectRatio:
                                                                    1.0,
                                                                child: Image.asset(Category
                                                                    .popularCourseList[
                                                                        i]
                                                                    .imagePath)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      14),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              Text(
                                                                Category
                                                                    .popularCourseList[
                                                                        i]
                                                                    .title,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      14.5,
                                                                  letterSpacing:
                                                                      0.2,
                                                                  color: DesignCourseAppTheme
                                                                      .lightText,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$${Category.popularCourseList[i].money}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.2,
                                                                  color: DesignCourseAppTheme
                                                                      .nearlyBlue,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                cartItemsList[
                                                                    i] = false;
                                                                cartItemCount--;

                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        'Item Removed',
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_SHORT,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor: DesignCourseAppTheme
                                                                        .nearlyBlue
                                                                        .withOpacity(
                                                                            0.7),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        14.0);
                                                              });
                                                              widget
                                                                  .callBack!(2);
                                                            },
                                                            child: Container(
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: DesignCourseAppTheme
                                                                    .lightText,
                                                                size: 32.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(),
                                  ],
                                )
                              : Container(
                                  child: Image.asset(
                                      'assets/images/emptyCart.png',
                                      scale: 1.6),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                cartItemCount > 0
                    ? Container(
                        child: Column(
                          children: [
                            const Divider(
                              height: 1,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                              color: DesignCourseAppTheme.lightText,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 14, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Total Amount: ',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 18,
                                        color: DesignCourseAppTheme.darkText),
                                  ),
                                  Text(
                                    totalAmount(),
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 18,
                                        color: DesignCourseAppTheme.nearlyBlue),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 40),
                              child: GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PatientDetail(
                                              callBack: (int a) {
                                                widget.callBack!(2);
                                                setState(() {});
                                              },
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: DesignCourseAppTheme.nearlyBlue
                                        .withOpacity(1),
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
                                      'Checkout',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        letterSpacing: 0.0,
                                        color: DesignCourseAppTheme.nearlyWhite,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
    //       }));
    //     },
    //     child: Hero(
    //       tag: heroAddTodo,
    //       createRectTween: (begin, end) {
    //         return CustomRectTween(begin: begin!, end: end!);
    //       },
    //       child: Material(
    //           color: Colors.blue,
    //           elevation: 2,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(40)),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Icon(
    //               Icons.shopping_cart_outlined,
    //               color: DesignCourseAppTheme.nearlyWhite,
    //               size: 30,
    //             ),
    //           )),
    //     ),
    //   ),
    // );
  }

  String totalAmount() {
    int totalAmount = 0;
    for (int i = 0; i < lenOfItems; i++) {
      if (cartItemsList[i]) {
        totalAmount = totalAmount + Category.popularCourseList[i].money.toInt();
      }
    }
    return '\$' + totalAmount.toString();
  }
}
