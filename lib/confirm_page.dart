// import 'dart:convert';
import 'package:medtest/services/database.dart';
import 'package:medtest/thankyou.dart';
import 'package:flutter/material.dart';
import 'package:medtest/medtest/medtest_app_theme.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';

class ConfirmPage extends StatefulWidget {
  final String formdata;
  final String loc;
  final String cart;
  final String latlng;
  const ConfirmPage(
      {super.key,
      required this.formdata,
      required this.loc,
      required this.latlng,
      required this.cart});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    Map formdata = stringtojsonmap();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        title: Text(
          'Confirmation',
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Please confirm the patient information:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkText,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: size.height / 1.525,
              width: size.width,
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
                          height: 10,
                        ),
                        textLine('Full Name', formdata['name']),
                        textLine('Gender', formdata['gender']),
                        textLine('Age', formdata['age'] + ' years'),
                        textLine('Phone Number', formdata['phnum']),
                        textLine('Appointment Date',
                            formdata['date'].substring(0, 10)),
                        textLine('Address', widget.loc),
                        Wrap(
                            children: [textLine('Tests Ordered', widget.cart)]),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 15,
            ),
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ThankyouPage(
                              data: DatabaseService(uid: user.uid)
                                  .patientOrderInfo(
                            formdata['name'],
                            int.parse(formdata['age']),
                            formdata['gender'],
                            widget.loc,
                            formdata['date'],
                            formdata['phnum'],
                            'Pending Validation',
                            widget.cart,
                            widget.latlng,
                          ))),
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
                        color: DesignCourseAppTheme.nearlyBlue.withOpacity(0.4),
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
                    ),
                  ),
                ),
              ),
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

  Map stringtojsonmap() {
    List<String> data =
        widget.formdata.replaceAll("{", "").replaceAll("}", "").split(",");
    Map<String, dynamic> finalData = {};
    for (int i = 0; i < data.length; i++) {
      List<String> s = data[i].split(":");
      finalData.putIfAbsent(s[0].trim(), () => s[1].trim());
    }

    return finalData;
  }
}
