import 'package:educationapp/UI/Auth/Login_Screen.dart';
import 'package:educationapp/UI/Auth/cubit/auth_cubit.dart';
import 'package:educationapp/UI/Auth/register_Screen.dart';
import 'package:educationapp/UI/Chat_Screen.dart';
import 'package:educationapp/controller/cubit/layout_cubit.dart';
import 'package:educationapp/core/Constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/HomeScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPref = await SharedPreferences.getInstance();
  constants.userUid = sharedPref.getString('userId');
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LayoutCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: constants.userUid == null ? LoginScreen() : const homeScreen()),
    );
  }
}
