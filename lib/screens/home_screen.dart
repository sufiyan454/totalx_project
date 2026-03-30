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
      appBar: AppBar(title: const Text("Users")),
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

      // ✅ SEARCH (FIXED)
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

                  // ✅ IMAGE FIX
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
