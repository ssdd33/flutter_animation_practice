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
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.1,
              duration: const Duration(milliseconds: 500),
              child: Container(
                  height: 300,
                  width: 300,
                  color: Colors.blue,
                  child: const Center(
                      child: Text('click me!',
                          style: TextStyle(color: Colors.black)))),
            ),
          ),
        ),
      ),
    );
  }
}
