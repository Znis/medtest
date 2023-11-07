import 'package:medtest/medtest/medtest_app_theme.dart';
// import 'package:medtest/login.dart';
// import 'package:medtest/model/patientInfo.dart';
import 'package:medtest/model/user.dart';
import 'package:medtest/orderDetail.dart';
// import 'package:medtest/services/auth.dart';
// import 'package:medtest/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  const History({
    Key? key,
  }) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<List<UserOrderData>>(context);
    bool largerthanone = false;

    for (var item in history) {
      if (item.status == 'Finished' ||
          item.status == 'Cancelled' ||
          item.status == 'Location Not Feasible' ||
          item.status == 'Out of Stock') {
        largerthanone = true;
        break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: DesignCourseAppTheme.nearlyWhite,
          foregroundColor: DesignCourseAppTheme.nearlyBlue,
          title: Text(
            'History',
            style:
                TextStyle(color: DesignCourseAppTheme.lightText, fontSize: 24),
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
        body: largerthanone
            ? ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  return history[index].status == 'Finished' ||
                          history[index].status == 'Cancelled' ||
                          history[index].status == 'Location Not Feasible' ||
                          history[index].status == 'Out of Stock'
                      ? GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OrderDetail(data: history[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                              child: ListTile(
                                leading: Icon(Icons.access_time),
                                title: Text(history[index].name),
                                trailing:
                                    appropriateIcon(history[index].status),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              )
            : Center(
                child: Text('No History',
                    style: TextStyle(
                        color: DesignCourseAppTheme.darkText, fontSize: 16))));
  }

  Widget appropriateIcon(String status) {
    dynamic ret;
    if (status == 'Cancelled') {
      ret = Icon(
        Icons.closed_caption_off_outlined,
        color: Colors.red[400],
      );
    } else if (status == 'Finished') {
      ret = Icon(
        Icons.check,
        color: Colors.green[400],
      );
    } else if (status == 'Out of Stock') {
      ret = Icon(
        Icons.invert_colors_off_sharp,
        color: Colors.orange[400],
      );
    } else if (status == 'Location Not Feasible') {
      ret = Icon(
        Icons.location_disabled_outlined,
        color: Colors.pink[400],
      );
    } else {
      ret = Icon(
        Icons.check,
      );
    }
    return ret;
  }
}
