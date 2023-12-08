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
        body: Center(child: MyAnimatedWidget()),
      ),
    );
  }
}

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key});

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
            opacity: animation.value,
            child: Container(
              height: 200,
              width: 200,
              color: Colors.blue,
            ));
      },
    );
  }
}
