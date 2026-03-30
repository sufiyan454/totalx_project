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
      appBar: AppBar(
        title: const Text("Users"),

        // ✅ FILTER ICON
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddUserScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            // 🔍 SEARCH
            TextField(
              onChanged: p.search,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 📋 LIST
            Expanded(
              child: ListView.builder(
                itemCount: p.users.length,
                itemBuilder: (context, index) {
                  final u = p.users[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [

                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              u.image.isNotEmpty ? FileImage(File(u.image)) : null,
                          child: u.image.isEmpty
                              ? const Icon(Icons.person)
                              : null,
                        ),

                        const SizedBox(width: 10),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(u.name),
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

// ✅ BOTTOM SHEET (SORT)
Widget buildSortSheet(BuildContext context) {
  final p = Provider.of<UserProvider>(context, listen: false);

  return Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        const Text("Sort By"),

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