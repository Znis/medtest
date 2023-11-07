import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'medtest/medtest_app_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ReportDetail extends StatefulWidget {
  final docId;
  const ReportDetail({super.key, required this.docId});

  @override
  State<ReportDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  late Future<ListResult> futureFiles;
  Map<int, double> downloadProgress = {};

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/reports').listAll();
  }

  Color btnColor = DesignCourseAppTheme.lightText;
  dynamic globalfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignCourseAppTheme.nearlyWhite,
        foregroundColor: DesignCourseAppTheme.nearlyBlue,
        title: Text(
          'Report Detail',
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
      body: FutureBuilder(
        future: futureFiles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];
                        file.name == widget.docId + '.jpg'
                            ? globalfile = file
                            : null;

                        double? progress = downloadProgress[index];

                        return file.name == widget.docId + '.jpg'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(file.name),
                                  subtitle: progress != null
                                      ? LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor:
                                              DesignCourseAppTheme.nearlyBlue,
                                        )
                                      : null,
                                  trailing: IconButton(
                                    icon: Icon(Icons.download, color: btnColor),
                                    onPressed: () => downloadFile(index, file),
                                  ),
                                ),
                              )
                            : Container();
                      }),
                ),
                // Expanded(
                //     // child: Image.network(getImgUrl(globalfile).toString())),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error Occured'),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.waveDots(
                  color: Colors.lightBlue,
                  size: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Loading Datas'),
              ],
            ),
          );
        },
      ),
    );
  }

  Future downloadFile(int index, Reference ref) async {
    final url = await ref.getDownloadURL();

    final tempdir = await getTemporaryDirectory();
    final path = '${tempdir.path}/${ref.name}';
    await Dio().download(url, path, onReceiveProgress: (received, total) {
      double progress = received / total;

      setState(() {
        btnColor = DesignCourseAppTheme.nearlyBlue;

        downloadProgress[index] = progress;
      });
    });

    if (url.contains('.jpg')) {
      await GallerySaver.saveImage(path, toDcim: true);
    }

    Fluttertoast.showToast(
        msg: 'Downloaded ${ref.name}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[400],
        textColor: Colors.white,
        fontSize: 14.0);
  }


}
