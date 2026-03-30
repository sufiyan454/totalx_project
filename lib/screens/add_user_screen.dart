import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final age = TextEditingController();

  File? image;

  // 📸 PICK IMAGE
  Future<void> pickImage() async {
    final picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // 👤 IMAGE PICKER
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    image != null ? FileImage(image!) : null,
                child: image == null
                    ? const Icon(Icons.add)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 NAME
            TextField(
              controller: name,
              decoration: const InputDecoration(hintText: "Name"),
            ),

            // 📱 PHONE
            TextField(
              controller: phone,
              decoration: const InputDecoration(hintText: "Phone"),
              keyboardType: TextInputType.phone,
            ),

            // 🎂 AGE
            TextField(
              controller: age,
              decoration: const InputDecoration(hintText: "Age"),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            // 💾 SAVE BUTTON
            ElevatedButton(
              onPressed: () {
                p.addUser(
                  UserModel(
                    name: name.text,
                    phone: phone.text,
                    age: int.parse(age.text),
                    image: image?.path ?? "",
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}