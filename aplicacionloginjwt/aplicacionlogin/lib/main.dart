import 'package:aplicacionlogin/pages/login_screen.dart';
import 'package:aplicacionlogin/pages/register_screen.dart';
import 'package:aplicacionlogin/pages/users_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/users': (context) => UsersScreen(),
      },
    );
  }
}
