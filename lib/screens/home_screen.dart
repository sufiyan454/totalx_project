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
      body: Column(
        children: [
          TextField(
            onChanged: p.search,
            decoration: const InputDecoration(hintText: "Search"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: p.users.length,
              itemBuilder: (contex,index) {
                final u = p.users[index];
                return ListTile(
                  title: Text(u.name),
                  subtitle: Text("${u.phone} | Age: ${u.age}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}