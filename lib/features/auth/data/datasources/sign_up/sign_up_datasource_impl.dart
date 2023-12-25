import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/models/user_model.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/features/auth/data/datasources/sign_up/sign_up_datasource.dart';
import 'package:social_app/features/auth/domain/entities/create_user_params.dart';
import 'package:social_app/features/auth/domain/entities/sign_up_params.dart';
import 'package:social_app/service_locator.dart';

class SignUpDataSourceImpl implements SignUpDataSource {
  @override
  Future<UserCredential> signUp({required SignUpParams signUpParams}) async {
    return await getIt.get<FirebaseAuth>().createUserWithEmailAndPassword(
          email: signUpParams.email,
          password: signUpParams.password,
        );
  }

  @override
  Future<void> firestoreCreateUSer({
    required CreateUserParams createUserParams,
  }) async {
    UserModel userModel = UserModel(
      name: createUserParams.name,
      email: createUserParams.email,
      phone: createUserParams.phone,
      uId: createUserParams.uId,
      isEmailVerified: false,
      image:
          'https://img.freepik.com/free-icon/user_318-159711.jpg?size=626&ext=jpg&ga=GA1.2.825316313.1674289475&semt=ais',
      bio: 'Write your bio...',
      cover: 'https://notepd.s3.amazonaws.com/default-cover.png',
    );
    await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(createUserParams.uId)
        .set(userModel.toJson());
  }
}
