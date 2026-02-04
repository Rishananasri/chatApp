import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/views/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void signOut() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Conform logout'),
            content: Text('Are you sure you want to logout?'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red.shade300),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: () {
                  final authservice = Provider.of<AuthService>(
                    context,
                    listen: false,
                  );
                  authservice.signOut();
                  Navigator.pop(context);
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
    }

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.message, size: 40)),

          Padding(
            padding:  EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('P R O F I L E'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('S E T T I N G S'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: signOut,
            ),
          ),
        ],
      ),
    );
  }
}