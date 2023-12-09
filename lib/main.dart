// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Ball> _balls;
  @override
  void initState() {
    super.initState();
    _balls = [
      Ball(
          color: Colors.red,
          radius: 50,
          position: const Offset(100, 100),
          velocity: const Offset(1, 1)),
      Ball(
          color: Colors.blue,
          radius: 40,
          position: const Offset(200, 200),
          velocity: const Offset(1, 1)),
      Ball(
        color: Colors.green,
        radius: 30,
        position: const Offset(300, 300),
      ),
    ];

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..addListener(() {
            for (int i = 0; i < _balls.length; i++) {
              _balls[i].position += _balls[i].velocity * _controller.value;
              print("[ $i ] ${_balls[i].position}");
            }
            _checkCollisions();
            setState(() {});
          });

    _controller.repeat();
  }

  void _checkCollisions() {
    for (int i = 0; i < _balls.length; i++) {
      for (int j = 1 + i; j < _balls.length; j++) {
        Ball ib = _balls[i];
        Ball jb = _balls[j];
        final double dx = jb.position.dx - ib.position.dx;
        final double dy = jb.position.dy - ib.position.dy;
        final double distance = sqrt(dx * dx - dy * dy);
        final double minDistance = jb.radius + ib.radius;
        if (distance <= minDistance) {
          final double angle = atan2(dy, dx);
          final Offset collisionDirection = Offset(cos(angle), sin(angle));
          final Offset normal1 = collisionDirection;
          final Offset normal2 = -collisionDirection;
          final relativeVelocity = ib.velocity - jb.velocity;
          final double dotProduct1 = relativeVelocity.dx * normal1.dx +
              relativeVelocity.dy * normal1.dy;
          final double dotProduct2 = relativeVelocity.dx * normal2.dx +
              relativeVelocity.dy * normal2.dy;
          _balls[j].velocity -=
              Offset(dotProduct1 * normal1.dx, dotProduct1 * normal1.dy);
          _balls[i].velocity -=
              Offset(dotProduct2 * normal2.dx, dotProduct2 * normal2.dy);
        }
      }
    }
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
          child: CustomPaint(
            painter: BallPainter(balls: _balls),
          ),
        ),
      ),
    );
  }
}

class Ball {
  Color color;
  double radius;
  Offset position;
  Offset velocity;
  Ball({
    required this.color,
    required this.radius,
    required this.position,
    this.velocity = Offset.zero,
  });
}

class BallPainter extends CustomPainter {
  final List<Ball> balls;
  BallPainter({
    required this.balls,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var ball in balls) {
      canvas.drawCircle(
          ball.position, ball.radius, Paint()..color = ball.color);
    }
  }

  @override
  bool shouldRepaint(covariant BallPainter oldDelegate) {
    return true;
  }
}
