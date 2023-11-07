import 'package:medtest/medtest/medtest_app_theme.dart';
// import 'package:medtest/login.dart';
// import 'package:medtest/model/patientInfo.dart';
import 'package:medtest/model/user.dart';
import 'package:medtest/orderDetail.dart';
// import 'package:medtest/services/auth.dart';
// import 'package:medtest/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActiveOrder extends StatefulWidget {
  final history;
  ActiveOrder({Key? key, this.history}) : super(key: key);

  @override
  State<ActiveOrder> createState() => _ActiveOrderState();
}

class _ActiveOrderState extends State<ActiveOrder> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final history = Provider.of<List<UserOrderData>>(context);
    bool largerthanone = false;

    for (var item in history) {
      if (item.status != 'Finished' &&
          item.status != 'Deleted' &&
          item.status != 'Cancelled' &&
          item.status != 'Location Not Feasible' &&
          item.status != 'Out of Stock') {
        largerthanone = true;
        break;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: DesignCourseAppTheme.nearlyWhite,
          foregroundColor: DesignCourseAppTheme.nearlyBlue,
          title: Text(
            'Active Orders',
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
                  return history[index].status != 'Finished' &&
                          history[index].status != 'Deleted' &&
                          history[index].status != 'Location Not Feasible' &&
                          history[index].status != 'Out of Stock' &&
                          history[index].status != 'Cancelled'
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
                child: Text(
                'No Active Orders',
                style: TextStyle(
                    color: DesignCourseAppTheme.darkText, fontSize: 16),
              )));
  }

  Widget appropriateIcon(String status) {
    dynamic ret;
    if (status == 'En Route') {
      ret = Icon(
        Icons.car_repair,
        color: Colors.green[400],
      );
    } else if (status == 'Pending Validation') {
      ret = Icon(
        Icons.hourglass_empty_outlined,
        color: Colors.purple[400],
      );
    } else if (status == 'Validation Completed') {
      ret = Icon(
        Icons.check,
        color: Colors.blue[400],
      );
    } else if (status == 'Sample Collected') {
      ret = Icon(
        Icons.check_box_outlined,
        color: Colors.green[400],
      );
    } else {
      ret = Icon(
        Icons.check,
      );
    }
    return ret;
  }
}
