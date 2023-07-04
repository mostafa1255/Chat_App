import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/core/Constants.dart';
import 'package:educationapp/models/message_model.dart';
import 'package:educationapp/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  userModel? usermodel;

  // ignore: non_constant_identifier_names
  void GetMyData() async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(constants.userUid!)
          .get();
      final userdata = userDoc.data()!;
      usermodel = userModel.fromJcon(data: userdata);
      debugPrint("User name: ${usermodel?.name}");
      emit(UpdateData());
      emit(GetmydataSucsess());
    } on FirebaseException catch (e) {
      emit(GetmydataFaliure(errmessage: e.message));
    }
  }

  List<userModel> users = [];
  void GetUserData() async {
    users.clear();
    emit(Loadinguserdata());
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection('users').get();

      for (var item in userDoc.docs) {
        if (item.id != constants.userUid) {
          users.add(userModel.fromJcon(data: item.data()));
        }
      }
      emit(GetUserdataSucsess());
    } on FirebaseException catch (e) {
      emit(GetUserdataFaliure());
    }
  }

  List<userModel> usersFiltered = [];
  void searchAboutuser({required String query}) {
    usersFiltered = users
        .where(
            (user) => user.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(FiltereduserSucsess());
  }

  bool searchEnabled = false;
  void changesearchstatus() {
    searchEnabled = !searchEnabled;
    if (searchEnabled == false) {
      usersFiltered.clear();
    }
    emit(ChangesearchStatusSucsess());
  }

  void sendMessgae({required String Message, required String reciverid}) async {
    try {
      messageModel messagemodel = messageModel(
          message: Message,
          date: DateTime.now().toString(),
          senderid: constants.userUid);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(constants.userUid)
          .collection('chat')
          .doc(reciverid)
          .collection('messages')
          .add(messagemodel.toJcon());
      print(" Send message Sucsess ");
      emit(sendMessagesucsess());
    } on FirebaseException catch (e) {
      emit(sendMessageFaliure(errmessage: e.message));
    }
  }

  List<messageModel> messages = [];
  void getMessages({required String reciverId}) {
    emit(getMessageLoading());
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(constants.userUid)
          .collection('chat')
          .doc(reciverId)
          .collection('messages')
          .snapshots()
          .listen((value) {
        messages.clear();

        for (var item in value.docs) {
          messages.add(messageModel.fromJcon(data: item.data()));
        }

        debugPrint("Messages length is : ${messages.length}");
        emit(getMessagesucsess());
      });
    } on FirebaseException catch (e) {
      emit(getMessageFaliure(errmessage: e.message));
    }
  }
}
