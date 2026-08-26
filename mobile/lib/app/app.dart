import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import 'theme.dart';

class ActifyApp extends StatelessWidget {
  const ActifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACTIFY',
      debugShowCheckedModeBanner: false,
      theme: ActifyTheme.dark(),
      home: const HomeScreen(),
    );
  }
}
