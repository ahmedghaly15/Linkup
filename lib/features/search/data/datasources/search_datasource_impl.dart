import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/search/data/datasources/search_datasource.dart';
import 'package:social_app/service_locator.dart';

class SearchDataSourceImpl implements SearchDataSource {
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> search() async {
    return await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .get();
  }
}
