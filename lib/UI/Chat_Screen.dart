import 'package:educationapp/controller/cubit/layout_cubit.dart';
import 'package:educationapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: camel_case_types
class chatScreen extends StatelessWidget {
  chatScreen({super.key, required this.usermodel});
  final userModel usermodel;
  final messgeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final layoutCubit = BlocProvider.of<LayoutCubit>(context)
      ..getMessages(reciverId: usermodel.id!);
    return BlocConsumer<LayoutCubit, LayoutState>(
      listener: (context, state) {
        if (state is getMessagesucsess) {}
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(usermodel.name!),
          ),
          body: Column(
            children: [
              Expanded(
                  child: state is getMessageLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : layoutCubit.messages.isNotEmpty
                          ? ListView.builder(
                              reverse: true,
                              itemCount: layoutCubit.messages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        top: 32,
                                        bottom: 32,
                                        right: 32),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(18),
                                            bottomLeft: Radius.circular(18),
                                            bottomRight: Radius.circular(18)),
                                        color: Colors.grey),
                                    child: IntrinsicWidth(
                                      child: Text(
                                        layoutCubit.messages[index].message
                                            .toString(),
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text("No message Yet"),
                            )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextFormField(
                  controller: messgeController,
                  decoration: InputDecoration(
                      hintText: "Type a Message",
                      suffixIcon: IconButton(
                          onPressed: () {
                            layoutCubit.sendMessgae(
                                Message: messgeController.text,
                                reciverid: usermodel.id.toString());
                            messgeController.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.blue,
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
