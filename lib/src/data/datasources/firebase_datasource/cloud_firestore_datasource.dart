import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CloudFirestoreDatasource {
  Future<void> saveUserInformation();

}
