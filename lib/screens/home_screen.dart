import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totakx_project/screens/add_user_screen.dart';
import '../providers/user_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddUserDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: SafeArea(
        child: Column(
          children: [

            // 🔝 HEADER (BLACK)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              color: Colors.black,
              child: const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    "Nilambur",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔍 SEARCH + FILTER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [

                  // SEARCH BAR
                  Expanded(
                    child: TextField(
                      onChanged: p.search,
                      decoration: InputDecoration(
                        hintText: "search by name",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // FILTER BUTTON
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => buildSortSheet(context),
                      );
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 📋 USER LIST
            Expanded(
              child: ListView.builder(
                itemCount: p.users.length,
                itemBuilder: (context, index) {
                  final u = p.users[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: u.image.isNotEmpty
                              ? FileImage(File(u.image))
                              : null,
                          child: u.image.isEmpty
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(u.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text("Age: ${u.age}"),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget buildSortSheet(BuildContext context) {
  final p = Provider.of<UserProvider>(context, listen: false);

  int selected = 0; // 0 = All, 1 = Elder, 2 = Younger

  return StatefulBuilder(
    builder: (context, setState) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Sort",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // 🔘 ALL
            RadioListTile(
              value: 0,
              groupValue: selected,
              onChanged: (v) {
                setState(() => selected = v!);
                p.refresh();
                Navigator.pop(context);
              },
              title: const Text("All"),
            ),

            // 🔘 ELDER
            RadioListTile(
              value: 1,
              groupValue: selected,
              onChanged: (v) {
                setState(() => selected = v!);
                p.sortOlder();
                Navigator.pop(context);
              },
              title: const Text("Age: Elder"),
            ),

            // 🔘 YOUNGER
            RadioListTile(
              value: 2,
              groupValue: selected,
              onChanged: (v) {
                setState(() => selected = v!);
                p.sortYounger();
                Navigator.pop(context);
              },
              title: const Text("Age: Younger"),
            ),
          ],
        ),
      );
    },
  );
}