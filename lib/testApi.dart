import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_model.dart';

class testApi {
  userModel? usermodel;
  void GetMydata() async {
    try {
      print("above code tset");
      await FirebaseFirestore.instance
          .collection("users")
          .doc("k34jdaow0YaLgotbi4I4bOJofQh2")
          .get()
          .then((value) {
        print("<mostafaaaaa>");
        print("uid isssssss ${usermodel?.name}");
        print("uid isssssss ${usermodel?.email}");
        print("uid isssssss ${usermodel?.image}");
        print("uid isssssss ${usermodel?.id}");
      });
    } on FirebaseException catch (e) {
      print("in catsh");
      print(e.message);
    }
  }
}
