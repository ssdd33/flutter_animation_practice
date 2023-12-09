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
  late List<Particle> particles;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 15));
    particles = List.generate(
      70,
      (index) => Particle(
        position: Offset(
          Random().nextInt(400).toDouble(),
          Random().nextInt(500).toDouble(),
        ),
        velocity: Offset(
          Random().nextDouble() * 200 - 100,
          Random().nextDouble() * 200 - 100,
        ),
      ),
    );

    _controller.addListener(() {
      final dt = _controller.value - (_controller.value - 0.001).clamp(0.0, 1);
      for (var particle in particles) {
        particle.update(dt);
      }

      setState(() {});
    });

    _controller.repeat();
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
      theme: ThemeData(canvasColor: Colors.black),
      home: Scaffold(
        body: CustomPaint(
          painter: ParticlePainter(particles: particles),
        ),
      ),
    );
  }
}

class Particle {
  Offset position;
  Offset velocity;
  Particle({
    required this.position,
    required this.velocity,
  });

  void update(double dt) {
    position += velocity * dt;
    velocity += const Offset(0, 400) * dt;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter({
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orangeAccent;
    for (var particle in particles) {
      canvas.drawCircle(particle.position, 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return true;
  }
}
