import 'dart:math';

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
  final bool _isTop = true;
  double _top = 5;
  double _left = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            color: Colors.blue,
            child: Stack(
              children: [
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    top: _top,
                    left: _left,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _top = Random().nextDouble() * 255;
                          _left = Random().nextDouble() * 255;
                          if (_top < 5) {
                            _top = 5;
                          }
                          if (_left < 5) {
                            _left = 5;
                          }
                        });
                      },
                      child: const Icon(
                        Icons.bug_report,
                        color: Colors.white,
                        size: 50,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
