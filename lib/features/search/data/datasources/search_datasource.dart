import 'package:cloud_firestore/cloud_firestore.dart';

abstract class SearchDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> search();
}
