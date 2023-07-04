import 'package:educationapp/UI/Auth/Login_Screen.dart';
import 'package:educationapp/UI/Auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat App"),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFaluire) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.errmessage)));
            } else if (state is AuthSucsess) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    BlocProvider.of<AuthCubit>(context).userImage != null
                        ? Column(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundImage: FileImage(
                                    BlocProvider.of<AuthCubit>(context)
                                        .userImage!),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  BlocProvider.of<AuthCubit>(context)
                                      .GetImage();
                                },
                                child: Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(15)),
                                  child: const Center(
                                    child: Text(
                                      "Change Image",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : OutlinedButton(
                            style: const ButtonStyle(
                                iconSize: MaterialStatePropertyAll(24),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.black26)),
                            onPressed: () {
                              BlocProvider.of<AuthCubit>(context).GetImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Select Image")
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)))),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)))),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                        controller: PasswordController,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)))),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (emailController.text.isNotEmpty &&
                              PasswordController.text.isNotEmpty) {
                            BlocProvider.of<AuthCubit>(context).register(
                                name: nameController.text,
                                Email: emailController.text,
                                Password: PasswordController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Please Form the Fields")));
                          }
                        },
                        child: state is LoadingState
                            ? const Text("Prossesing...")
                            : const Text("Sign Up"))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
