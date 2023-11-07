// import 'package:medtest/report.dart';
import 'package:medtest/reportDetail.dart';
import 'package:medtest/services/database.dart';
// import 'package:medtest/thankyou.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';
// import 'model/user.dart';

class OrderDetail extends StatefulWidget {
  final data;
  const OrderDetail({super.key, required this.data});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        title: Text(
          'Order Detail',
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
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: size.width,
              height: size.height / 1.365,
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: DesignCourseAppTheme.notWhite),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Scrollbar(
                controller: _scrollController,
                thickness: 4,
                thumbVisibility: true,
                scrollbarOrientation: ScrollbarOrientation.right,
                radius: Radius.circular(20),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        textLine('Full Name', widget.data.name),
                        textLine('Gender', widget.data.gender),
                        textLine('Age', widget.data.age.toString() + ' years'),
                        textLine('Phone Number', widget.data.phnum),
                        textLine('Appointment Date', widget.data.datetime),
                        textLine('Address', widget.data.address),
                        Wrap(children: [
                          textLine('Tests Booked', widget.data.order)
                        ]),
                        textLine('Status', widget.data.status),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ),
            ),
            widget.data.status == 'Finished' ||
                    widget.data.status == 'Cancelled' ||
                    widget.data.status == 'Location Not Feasible' ||
                    widget.data.status == 'Out of Stock'
                ? Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await DatabaseService(uid: user.uid).patientOrderInfo(
                          //     formdata['name'],
                          //     int.parse(formdata['age']),
                          //     formdata['gender'],
                          //     widget.loc,
                          //     formdata['date'],
                          //     formdata['phnum'],
                          //     'Pending');

                          // await Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => ThankyouPage()),
                          // );
                        },
                        child: widget.data.status == 'Finished'
                            ? GestureDetector(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReportDetail(
                                              docId: widget.data.id,
                                            )),
                                  );
                                },
                                child: Container(
                                  height: 48,
                                  width: size.width / 1.5,
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
                                      'Lab Report',
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
                              )
                            : Container(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DatabaseService()
                              .patientOrdersInfo
                              .doc(widget.data.id)
                              .update({'status': 'Deleted'}).whenComplete(() {
                            Fluttertoast.showToast(
                                msg: 'Order Removed',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: DesignCourseAppTheme.nearlyBlue
                                    .withOpacity(0.7),
                                textColor: Colors.white,
                                fontSize: 14.0);
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          width: size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Delete',
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
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: size.height / 14,
                      ),
                      GestureDetector(
                        onTap: () async {
                          DatabaseService()
                              .patientOrdersInfo
                              .doc(widget.data.id)
                              .update({'status': 'Cancelled'}).whenComplete(() {
                            Fluttertoast.showToast(
                                msg: 'Order Cancelled',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: DesignCourseAppTheme.nearlyBlue
                                    .withOpacity(0.7),
                                textColor: Colors.white,
                                fontSize: 14.0);
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 48,
                          width: size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  offset: const Offset(1.1, 1.1),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Cancel Order',
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
                  ),
          ],
        ),
      ),
    );
  }

  Widget textLine(String labelTxt, String valueTxt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 14,
        ),
        Text(
          labelTxt,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            letterSpacing: 0.27,
            color: DesignCourseAppTheme.darkText,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          valueTxt,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.27,
            color: DesignCourseAppTheme.lightText,
          ),
        ),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
