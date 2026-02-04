import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title:  Text("M E"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: const Color.fromARGB(255, 242, 122, 57),
              child: Text(
                user?.email?[0].toUpperCase() ?? "?",
                style:  TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

           SizedBox(height: 30),

          Text(
            user?.email ?? "No Email Found",
            style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),

           SizedBox(height: 10),

          Text(
            "UID: ${user?.uid ?? "No id"}",
            style:  TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}