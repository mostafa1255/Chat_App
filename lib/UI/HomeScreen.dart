import 'package:educationapp/UI/Auth/Login_Screen.dart';
import 'package:educationapp/UI/Chat_Screen.dart';
import 'package:educationapp/controller/cubit/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..GetMyData()
      ..GetUserData();
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is UpdateData) {}
      },
      builder: (context, state) {
        return Scaffold(
            drawer: Drawer(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                layoutCubit.usermodel != null
                    ? UserAccountsDrawerHeader(
                        accountName: Text(layoutCubit.usermodel!.name!),
                        accountEmail: Text(layoutCubit.usermodel!.email!),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              NetworkImage(layoutCubit.usermodel!.image!),
                        ),
                      )
                    : const Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "No user data has Found",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                Expanded(
                    child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Container(
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.logout),
                            Text("Logout")
                          ],
                        ),
                      ),
                    )
                  ],
                ))
              ],
            )),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      layoutCubit.changesearchstatus();
                    },
                    icon: layoutCubit.searchEnabled
                        ? const Icon(Icons.clear)
                        : const Icon(Icons.search))
              ],
              title: layoutCubit.searchEnabled
                  ? TextField(
                      onChanged: (value) {
                        layoutCubit.searchAboutuser(query: value);
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Here...",
                      ),
                    )
                  : const Text("Home Screen"),
            ),
            body: state is Loadinguserdata
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : layoutCubit.users.isEmpty
                    ? const Center(
                        child: Text(
                          "There is no user ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount: layoutCubit.searchEnabled
                            ? layoutCubit.usersFiltered.length
                            : layoutCubit.users.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 7, top: 4),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => chatScreen(
                                        usermodel: layoutCubit
                                                .usersFiltered.isEmpty
                                            ? layoutCubit.users[index]
                                            : layoutCubit.usersFiltered[index]),
                                  )),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(13))),
                                child: layoutCubit.searchEnabled
                                    ? Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                                layoutCubit.usersFiltered[index]
                                                    .image!),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            layoutCubit
                                                .usersFiltered[index].name!,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 35,
                                            backgroundImage: NetworkImage(
                                                layoutCubit
                                                    .users[index].image!),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            layoutCubit.users[index].name!,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          );
                        },
                      ));
      },
    );
  }
}
