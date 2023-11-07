import 'package:medtest/reportDetail.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'medtest/medtest_app_theme.dart';
import 'model/user.dart';

class LabReport extends StatefulWidget {
  const LabReport({super.key});

  @override
  State<LabReport> createState() => _LabReportState();
}

class _LabReportState extends State<LabReport> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<List<UserOrderData>>(context);
    bool largerthanone = false;

    for (var item in history) {
      if (item.status == 'Finished') {
        largerthanone = true;
        break;
      }
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: DesignCourseAppTheme.nearlyWhite,
          foregroundColor: DesignCourseAppTheme.nearlyBlue,
          title: Text(
            'Lab Reports',
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
                  return history[index].status == 'Finished'
                      ? GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ReportDetail(docId: history[index].id)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.history,
                                  color: DesignCourseAppTheme.nearlyBlue,
                                ),
                                title: Text(history[index].name),
                                trailing: Icon(
                                  Icons.pending_actions_outlined,
                                  color: DesignCourseAppTheme.nearlyBlue,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              )
            : Center(
                child: Text('No Report Available',
                    style: TextStyle(
                        color: DesignCourseAppTheme.darkText, fontSize: 16))));
  }
}
