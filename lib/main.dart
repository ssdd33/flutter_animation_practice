import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnimationPage();
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _isAligned = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isAligned = !_isAligned;
            });
          },
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: AnimatedAlign(
              duration: const Duration(seconds: 1),
              alignment: _isAligned ? Alignment.topLeft : Alignment.bottomRight,
              child: const Icon(
                Icons.ads_click,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
