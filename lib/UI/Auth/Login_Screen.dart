import 'package:educationapp/UI/Auth/cubit/auth_cubit.dart';
import 'package:educationapp/UI/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat App"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSucsess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const homeScreen(),
                  ));
            } else if (state is LoginFaliure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errmessage)));
            }
          },
          builder: (context, state) {
            return state is LoadingState
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                            obscureText: false,
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)))),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                            obscureText: true,
                            controller: PasswordController,
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)))),
                        ElevatedButton(
                            onPressed: () {
                              if (emailController.text.isNotEmpty &&
                                  PasswordController.text.isNotEmpty) {
                                BlocProvider.of<AuthCubit>(context).Login(
                                    Email: emailController.text,
                                    Password: PasswordController.text);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Please Form the Fields")));
                              }
                            },
                            child: const Text(
                              "Login",
                            ))
                      ],
                    ),
                  );
          },
        ));
  }
}
