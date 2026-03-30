import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'add_user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Users", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => buildSortSheet(context),
              );
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserDialog()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔍 SEARCH
            TextField(
              onChanged: p.search,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 USER LIST
            Expanded(
              child: ListView.builder(
                itemCount: p.users.length,
                itemBuilder: (context, index) {
                  final u = p.users[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
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
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(u.name,
                                style: const TextStyle(fontSize: 16)),
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

// ✅ SORT BOTTOM SHEET (ALREADY INCLUDED)
Widget buildSortSheet(BuildContext context) {
  final p = Provider.of<UserProvider>(context, listen: false);

  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        const Text("Sort By", style: TextStyle(fontSize: 18)),

        ListTile(
          title: const Text("All"),
          onTap: () {
            p.refresh();
            Navigator.pop(context);
          },
        ),

        ListTile(
          title: const Text("Older (60+)"),
          onTap: () {
            p.sortOlder();
            Navigator.pop(context);
          },
        ),

        ListTile(
          title: const Text("Younger (<60)"),
          onTap: () {
            p.sortYounger();
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}