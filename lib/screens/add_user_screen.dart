import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Add User")),
      body: Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: name, decoration:  InputDecoration(hintText: "Name")),
            TextField(controller: phone, decoration:  InputDecoration(hintText: "Phone")),
            TextField(controller: age, decoration:  InputDecoration(hintText: "Age")),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child:  Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}