import 'dart:async';

import 'package:flutter_project/data/models/user_model.dart';
import 'package:flutter_project/data/services/base_repository.dart';
import 'dart:developer';

class AuthRepository extends BaseRepository {

  Future<UserModel> signup({
    required String email,
    required String username,
    required String name,
    required String password,
    required String phoneNumber,
})  async
  {
    try {
      final userCredentials = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredentials.user == null ){
        throw "failed to create user";
      }

      // create user in firebase now
      final user = UserModel(
          uid: userCredentials.user!.uid,
          email: email,
          username: username,
          name: name,
          password: password,
          phoneNumber: phoneNumber,
      );
      await saveUserData(user);
      return user;

    } catch (e) {
      log(e.toString());
      throw Exception("Signup failed: $e");
    }
  }

  Future<UserModel> signin({
    required String email,
    required String password,
  })  async
  {
    try {
      final userCredentials = await auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredentials.user == null ){
        throw "User not found!";
      }
      // getting user data and returning
      final userData = await getUserData(userCredentials.user!.uid);
      return userData;

    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> saveUserData(UserModel user) async {
    try{
      firestore.collection("users").doc(user.uid).set(user.toMap());
    }catch(e){
      throw "failed to save user data";
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try{
      final doc = await firestore.collection("users").doc(uid).get();
      if(!doc.exists){
        throw "User data not found";
      }
      return UserModel.fromFirestore(doc);
    }catch(e){
      throw "failed to save user data";
    }
  }

}