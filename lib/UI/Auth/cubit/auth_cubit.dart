import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/core/Constants.dart';
import 'package:educationapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void register(
      {required String Email,
      required String Password,
      required String name}) async {
    emit(LoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);

      if (userCredential.user?.uid != null) {
        debugPrint("User craeted sucsess${userCredential.user!.uid}");
        String mos = await UploadImageToStorage();
        debugPrint("Imageeeee Url is $mos");
        sendUserDatatoFirestore(
            name: name,
            email: Email,
            UserId: userCredential.user!.uid,
            imageurl: mos);
        emit(AuthSucsess());
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Failed to regeister reason ${e.code}");
      if (e.code == "email-already-in-use") {
        emit(AuthFaluire(errmessage: "email is already used"));
      }
    }
  }

  void Login({
    required String Email,
    required String Password,
  }) async {
    emit(LoadingState());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);

      if (userCredential.user?.uid != null) {
        final sharedPref = await SharedPreferences.getInstance();
        await sharedPref.setString('userId', userCredential.user!.uid);
        emit(LoginSucsess());
      }
    } on FirebaseException catch (e) {
      emit(LoginFaliure("${e.message}"));
    }
  }

  File? userImage;
  void GetImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      userImage = File(pickedImage.path);
      emit(UserImageSelectedSucsess());
    } else {
      emit(UserImageSelectedFaliure());
    }
  }

  Future<String> UploadImageToStorage() async {
    debugPrint("File is : $userImage");
    debugPrint("Base name is : ${basename(userImage!.path)}");
    Reference Imageref =
        FirebaseStorage.instance.ref(basename(userImage!.path));
    await Imageref.putFile(userImage!);
    return await Imageref.getDownloadURL();
  }

  void sendUserDatatoFirestore(
      {required String name,
      required String email,
      required String UserId,
      required String imageurl}) async {
    userModel usermodel =
        userModel(email: email, id: UserId, image: imageurl, name: name);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(UserId)
          .set(usermodel.toJcon());
      emit(SucsessSavedatatofireStore());
    } on FirebaseException catch (e) {
      emit(FaliureSavedatatofireStore());
    }
  }
}
