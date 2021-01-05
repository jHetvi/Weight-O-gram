import 'package:cloud_firestore/cloud_firestore.dart';

class NewUser {
  static const NEWUSER_ID = "newUser_id";
  static const WEIGHT = "weight";
  static const CREATE_TIMESTAMP = "crte_tmstmp";

  String newUserId, weight;
  Timestamp createDateTime;

  NewUser({
    this.newUserId,
    this.weight,
    this.createDateTime,
  });

  factory NewUser.fromDocSnap(DocumentSnapshot docSnap) =>
      NewUser.fromMap(docSnap.data())..newUserId = docSnap.id;

  NewUser.fromMap(Map data) {
    this.newUserId = data[NEWUSER_ID];
    this.weight = data[WEIGHT];
    this.createDateTime = data[CREATE_TIMESTAMP];
  }

  Map<String, dynamic> toJson() => {
        NEWUSER_ID: newUserId,
        WEIGHT: weight,
        CREATE_TIMESTAMP: this.createDateTime,
      };
}
