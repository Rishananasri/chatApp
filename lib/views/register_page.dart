import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_fields.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final conformpasswordcontrololer = TextEditingController();

  void signUp() async {
    if (passwordcontroller.text != conformpasswordcontrololer.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar( SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
        emailcontroller.text.trim(),
        passwordcontroller.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:  EdgeInsets.symmetric(horizontal: 28.0, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding:  EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_add_alt_1,
                    size: 80,
                    color: Colors.blue.shade600,
                  ),
                ),
                 SizedBox(height: 20),

                Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                 SizedBox(height: 8),
                Text(
                  "Fill the details below to sign up",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.grey[600],
                  ),
                ),

                 SizedBox(height: 40),

                MyTextField(
                  controller: emailcontroller,
                  hintText: 'Enter your email',
                ),
                 SizedBox(height: 20),

                MyTextField(
                  controller: passwordcontroller,
                  hintText: 'Enter your password',
                  obscureText: true,
                ),
                 SizedBox(height: 20),

                MyTextField(
                  controller: conformpasswordcontrololer,
                  hintText: 'Confirm your password',
                  obscureText: true,
                ),
                 SizedBox(height: 30),

                MyButton(onTap: signUp, text: 'Register'),

                 SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 0.7, color: Colors.grey[400]),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "or",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Expanded(
                      child: Divider(thickness: 0.7, color: Colors.grey[400]),
                    ),
                  ],
                ),

                 SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login now",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}