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

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double _gravity = 9.8;

  double _objectY = 0.0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));

//왜 tween.animate로 할당하지 않고 따로 변수를 만들어서 animation에 할당하는지?
    final Tween<double> tween = Tween<double>(begin: 0.0, end: 11.0);
    _animation = tween
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//parent의 의미
//왜 controller가 아닌 animation에 리스너 다는지?
    _animation.addListener(() {
      setState(() {
        _objectY = (_gravity * _animation.value * _animation.value) / 2;
      });
    });
    //왜 여기선 _animation.forward()가 아닌지?
    _controller.forward();
    super.initState();
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
          child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 25,
                    top: _objectY,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ]);
              }),
        ),
      ),
    );
  }
}
