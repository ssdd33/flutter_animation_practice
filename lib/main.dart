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
  bool _showFirst = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
              onTap: () {
                setState(() {
                  _showFirst = !_showFirst;
                });
              },
              child: AnimatedCrossFade(
                duration: const Duration(milliseconds: 500),
                firstChild:
                    Image.network("https://source.unsplash.com/dfglhJbc4Uc"),
                secondChild:
                    Image.network("https://source.unsplash.com/w5N9CqsSnQ4"),
                crossFadeState: _showFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              )),
        ),
      ),
    );
  }
}
