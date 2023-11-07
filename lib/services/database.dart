import 'package:medtest/model/patientInfo.dart';
import 'package:medtest/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:latlong2/latlong.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference patientOrdersInfo =
      FirebaseFirestore.instance.collection('patientOrders');
  // int id =0;

  Future patientOrderInfo(
      String name,
      int age,
      String gender,
      String address,
      String datetime,
      String phnum,
      String status,
      String order,
      String latlng) async {
    return await patientOrdersInfo.doc().set({
      // 'pid': id,
      'uid': uid,
      'name': name,
      'age': age,
      'address': address,
      'phnum': phnum,
      'gender': gender,
      'datetime': datetime,
      'status': status,
      'order': order,
      'latlng': latlng,
    });
  }

  // Patient info list from snapshot
  List<PatientInfo> _patientInfoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PatientInfo(
        id: doc.id,
        name: doc['name'] ?? '',
        age: doc['age'] ?? 0,
        address: doc['address'] ?? '',
        phnum: doc['phnum'] ?? '',
        gender: doc['gender'] ?? '',
        datetime: doc['datetime'] ?? '',
        status: doc['status'] ?? '',
        order: doc['order'] ?? '',
      );
    }).toList();
  }

  // get brews PatientInfo
  Stream<List<PatientInfo>> get history {
    return patientOrdersInfo.snapshots().map(_patientInfoFromSnapshot);
  }

  // List<UserOrderData> _userOrderDataFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return UserOrderData(
  //       uid: doc['uid'],
  //       name: doc['name'] ?? '',
  //       age: doc['age'] ?? 0,
  //       address: doc['address'] ?? '',
  //       phnum: doc['phnum'] ?? '',
  //       gender: doc['gender'] ?? '',
  //       datetime: doc['datetime'] ?? '',
  //       status: doc['status'] ?? '',
  //     );
  //   }).toList();
  // }

  List<UserOrderData> _filterr(QuerySnapshot snapshot) {
    List<UserOrderData> data = snapshot.docs.map((doc) {
      return UserOrderData(
        id: doc.id,
        uid: doc['uid'],
        name: doc['name'] ?? '',
        age: doc['age'] ?? 0,
        address: doc['address'] ?? '',
        phnum: doc['phnum'] ?? '',
        gender: doc['gender'] ?? '',
        datetime: doc['datetime'] ?? '',
        status: doc['status'] ?? '',
        order: doc['order'] ?? '',
      );
    }).toList();
    List<UserOrderData> filteredData = [];
    for (var k in data) {
      if (uid! == k.uid) {
        filteredData.add(k);
      }
    }
    return filteredData;
  }

// get user doc stream
  Stream<List<UserOrderData>> get orderData {
    return patientOrdersInfo.snapshots().map(_filterr);
  }

  Future patientInfo(
      String name, int age, String gender, String address, String phnum) async {
    return await patientOrdersInfo.doc(uid).set({
      'name': name,
      'age': age,
      'address': address,
      'phnum': phnum,
      'gender': gender,
    });
  }
}
