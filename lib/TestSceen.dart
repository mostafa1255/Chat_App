import 'package:educationapp/testApi.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key});
  final testApi test = testApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Screen"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                print("above test");
                test.GetMydata();
                print("under test");
              },
              child: Text("Get Data"))
        ],
      ),
    );
  }
}
