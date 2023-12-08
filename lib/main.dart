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

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: CurvedAnmationWidget(),
        ),
      ),
    );
  }
}

class CurvedAnmationWidget extends StatefulWidget {
  const CurvedAnmationWidget({super.key});

  @override
  State<CurvedAnmationWidget> createState() => _CurvedAnmationWidgetState();
}

class _CurvedAnmationWidgetState extends State<CurvedAnmationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
        scale: _animation,
        child: Container(width: 200, height: 100, color: Colors.blue));

    return RotationTransition(
        turns: _animation,
        child: Container(height: 200, width: 200, color: Colors.blue));
  }
}
