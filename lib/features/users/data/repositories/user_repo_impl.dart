import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_app/core/errors/failure.dart';
import 'package:social_app/core/helpers/helper.dart';
import 'package:social_app/core/utils/app_strings.dart';
import 'package:social_app/core/utils/functions/execute_and_handle_errors.dart';
import 'package:social_app/features/users/data/datasources/user_datasource.dart';
import 'package:social_app/features/users/domain/repositories/user_repo.dart';
import 'package:social_app/service_locator.dart';

class UserRepoImpl implements UserRepo {
  final UserDataSource userDataSource;

  const UserRepoImpl({required this.userDataSource});

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return userDataSource.getUserData();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return userDataSource.getPosts();
  }

  @override
  Future<Either<Failure, void>> signOut() {
    return executeAndHandleErrors<void>(
      function: () => userDataSource.signOut(),
    );
  }

  @override
  Future<Either<Failure, void>> deleteAccount() {
    return executeAndHandleErrors<void>(function: () {
      return userDataSource.deleteAccount().then((value) async {
        _deleteAccountFromOtherUsersFollowers().then((value) {
          _deleteAccountFromOtherUsersFollowing().then((value) {
            _deleteAccountComments().then((value) {
              _deleteAccountLikes().then((value) {
                _deleteAccountPosts().then((value) {
                  _deleteAccountFollowers().then((value) {
                    _deleteAccountFollowing().then((value) {
                      _deleteFirestoreUser();
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  Future<void> _deleteFirestoreUser() async {
    await getIt
        .get<FirebaseFirestore>()
        .collection(AppStrings.users)
        .doc(Helper.uId)
        .delete();
  }

  Future<void> _deleteAccountFollowers() async {
    final followers = await _accessAccountFollowersCollection().get();

    for (var follower in followers.docs) {
      await _accessAccountFollowersCollection().doc(follower.id).delete();
    }
  }

  Future<void> _deleteAccountFollowing() async {
    final following = await _accessAccountFollowingCollection().get();

    for (var followed in following.docs) {
      await _accessAccountFollowingCollection().doc(followed.id).delete();
    }
  }

  Future<void> _deleteAccountLikes() async {
    final posts = await _accessPostsCollection().get();

    for (var post in posts.docs) {
      final likes = await _accessLikesCollection(post).get();

      for (var like in likes.docs) {
        if (like.data()['user']['uId'] == Helper.uId) {
          await _accessLikesCollection(post).doc(like.id).delete();
        }
      }
    }
  }

  Future<void> _deleteAccountComments() async {
    final posts = await _accessPostsCollection().get();

    for (var post in posts.docs) {
      final comments = await _accessCommentsCollection(post).get();

      for (var comment in comments.docs) {
        if (comment.data()['user']['uId'] == Helper.uId) {
          await _accessCommentsCollection(post).doc(comment.id).delete();
        }
      }
    }
  }

  Future<void> _deleteAccountPosts() async {
    final posts = await _accessPostsCollection().get();

    for (var post in posts.docs) {
      if (post.data()['user']['uId'] == Helper.uId) {
        await _accessPostsCollection().doc(post.id).delete();
      }
    }
  }

  Future<void> _deleteAccountFromOtherUsersFollowing() async {
    final users = await _accessUsersCollection().get();

    for (var user in users.docs) {
      final following = await _accessUsersCollection()
          .doc(user.id)
          .collection(AppStrings.following)
          .get();

      for (var followed in following.docs) {
        if (followed.id == Helper.uId) {
          await _accessUsersCollection()
              .doc(user.id)
              .collection(AppStrings.following)
              .doc(Helper.uId)
              .delete();
        }
      }
    }
  }

  Future<void> _deleteAccountFromOtherUsersFollowers() async {
    final users = await _accessUsersCollection().get();

    for (var user in users.docs) {
      final followers = await _accessUsersCollection()
          .doc(user.id)
          .collection(AppStrings.followers)
          .get();

      for (var follower in followers.docs) {
        if (follower.id == Helper.uId) {
          await _accessUsersCollection()
              .doc(user.id)
              .collection(AppStrings.followers)
              .doc(Helper.uId)
              .delete();
        }
      }
    }
  }

  CollectionReference<Map<String, dynamic>> _accessCommentsCollection(
          QueryDocumentSnapshot<Map<String, dynamic>> post) =>
      _accessPostsCollection().doc(post.id).collection(AppStrings.comments);

  CollectionReference<Map<String, dynamic>> _accessLikesCollection(
          QueryDocumentSnapshot<Map<String, dynamic>> post) =>
      _accessPostsCollection().doc(post.id).collection(AppStrings.likes);

  CollectionReference<Map<String, dynamic>> _accessPostsCollection() {
    return getIt.get<FirebaseFirestore>().collection(AppStrings.posts);
  }

  CollectionReference<Map<String, dynamic>>
      _accessAccountFollowingCollection() {
    return _accessUsersCollection()
        .doc(Helper.uId)
        .collection(AppStrings.following);
  }

  CollectionReference<Map<String, dynamic>> _accessUsersCollection() {
    return getIt.get<FirebaseFirestore>().collection(AppStrings.users);
  }

  CollectionReference<Map<String, dynamic>>
      _accessAccountFollowersCollection() {
    return _accessUsersCollection()
        .doc(Helper.uId)
        .collection(AppStrings.followers);
  }
}
