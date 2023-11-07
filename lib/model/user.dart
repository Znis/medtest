class User {
  final String uid;
  User({required this.uid});
}

class UserOrderData {
  final String uid;
  final String name;
  final String gender;
  final String address;
  final String datetime;
  final int age;
  final String phnum;
  final String status;
  final String order;
  final String id;
  UserOrderData(
      {required this.uid,
      required this.name,
      required this.gender,
      required this.address,
      required this.datetime,
      required this.age,
      required this.phnum,
      required this.status,
      required this.order,
      required this.id});
}
