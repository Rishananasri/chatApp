import 'package:chatapp/components/my_drawer.dart';
import 'package:chatapp/views/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'ChatApp',
          style: TextStyle(
            color: const Color.fromARGB(255, 242, 122, 57),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final userDocs = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              final doc = userDocs[index];

              if (doc.data() == null) return SizedBox.shrink();

              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              final email = data['email'] as String?;
              final uid = data['uid'] as String?;

              if (email == null || uid == null) return const SizedBox.shrink();

              if (_auth.currentUser!.email == email) {
                return SizedBox.shrink();
              }

              return UserCard(email: email, uid: uid);
            },
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String email;
  final String uid;

  const UserCard({super.key, required this.email, required this.uid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatPage(receiverUserEmail: email, receiverUseId: uid),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(133, 250, 229, 201),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color.fromARGB(255, 242, 122, 57),
                      child: Text(
                        email.isNotEmpty ? email[0].toUpperCase() : "?",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          email,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Tap to chat",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
