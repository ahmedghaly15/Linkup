import 'package:social_app/core/models/user_model.dart';

abstract class EditProfileDataSource {
  Future<void> updateUser({required UserModel userModel});
}
