// import 'package:medtest/model/patientInfo.dart';
// import 'package:medtest/model/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MediaService {
  final String docId;
  MediaService({required this.docId});

// Create a storage reference from our app
  final storageRef = FirebaseStorage.instance.ref('/reports');

  dynamic reportFile() async {
    Future<ListResult> futureFiles;
    futureFiles = storageRef.listAll();
    return await futureFiles;
  }
}
