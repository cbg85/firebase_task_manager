import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/task_list_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _signIn() async {
    User? user = await _authService.signIn(emailController.text, passwordController.text);
    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskListScreen()));
    }
  }

  void _register() async {
    await _authService.register(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
          TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
          ElevatedButton(onPressed: _signIn, child: Text("Sign In")),
          ElevatedButton(onPressed: _register, child: Text("Register")),
        ],
      ),
    );
  }
}
