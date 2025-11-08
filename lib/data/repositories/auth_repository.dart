import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project/data/models/user_model.dart';
import 'package:flutter_project/data/repositories/base_repository.dart';
import 'dart:developer';

class AuthRepository extends BaseRepository {

  Stream<User?> get authStateChanges => auth.authStateChanges();

  //--------- Sign up ----------------------------
  Future<UserModel> signup({
    required String email,
    required String username,
    required String name,
    required String password,
    required String phoneNumber,
})  async
  {
    try {

      final emailExists = await checkEmailExists(email);
      final phoneNumberExists = await checkPhoneNumberExists(phoneNumber);
      final usernameExists = await checkUsernameExists(username);

      if(emailExists){
        throw " A Email is already registered with this email address.";
      }
      if(usernameExists){
        throw " A username is already registered with this username.";
      }
      if(phoneNumberExists){
        throw " A Phone Number is already registered with this Number address.";
      }

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

  //-------- Log in -----------------
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

  // ----log out------
  Future<void> logout() async {
    await auth.signOut();
  }

  // --------- utilty methods ----------------------

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
      log(doc.id);
      return UserModel.fromFirestore(doc);
    }catch(e){
      throw "failed to save user data";
    }
  }

  Future<bool> checkEmailExists(String email) async{
    try{
      final method = await auth.fetchSignInMethodsForEmail(email);
      return method.isNotEmpty;
    } catch (e){
      print("Error Checking Email : $e");
      return false;
    }
  }

  Future<bool> checkPhoneNumberExists(String phoneNumber) async{
    try{
      final querySnapShot = await firestore.collection("users").where("phoneNumber",isEqualTo: phoneNumber).get();
      return querySnapShot.docs.isNotEmpty;
    } catch (e){
      print("Error Checking Phone Number : $e");
      return false;
    }
  }

  Future<bool> checkUsernameExists(String username) async{
    try{
      final querySnapShot = await firestore.collection("users").where("username",isEqualTo: username).get();
      return querySnapShot.docs.isNotEmpty;
    } catch (e){
      print("Error Checking Phone Number : $e");
      return false;
    }
  }


}