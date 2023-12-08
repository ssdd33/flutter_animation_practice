import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CurvedAnimationWidget();
  }
}

class CurvedAnimationWidget extends StatefulWidget {
  const CurvedAnimationWidget({super.key});

  @override
  State<CurvedAnimationWidget> createState() => _CurvedAnimationWidgetState();
}

class _CurvedAnimationWidgetState extends State<CurvedAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    const begin = Offset(0, 0);
    const controlPoint = Offset(0.5, 1);
    const end = Offset(1, 0.5);
    _animation = Tween<Offset>(begin: begin, end: end).animate(CurvedAnimation(
        parent: _controller,
        curve: Cubic(
          controlPoint.dx,
          controlPoint.dy,
          controlPoint.dx + 0.5,
          controlPoint.dy + 0.5,
        )));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SlideTransition(
              position: _animation,
              child: Container(height: 200, width: 200, color: Colors.blue)),
        ),
      ),
    );
  }
}
