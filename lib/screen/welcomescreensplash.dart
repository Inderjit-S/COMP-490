import 'dart:async';
import 'package:aerogotchi/screen/idlescreen.dart';
import 'package:aerogotchi/screen/petviewscreen.dart';
import 'package:flutter/material.dart';

class WelcomeSplashScreen extends StatefulWidget {
  final String petName;
  const WelcomeSplashScreen({Key? key, required this.petName})
      : super(key: key);

  @override
  _WelcomeSplashScreenState createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _slideUpAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );
    _slideUpAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate to PetViewScreen after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(seconds: 1), () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PetViewScreen(
                      petName: '',
                    )),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Start off white
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Background color transition
              Positioned.fill(
                child: Container(
                  color: Color.lerp(
                    Colors.white,
                    Colors.blue,
                    _fadeInAnimation.value,
                  ),
                ),
              ),
              // Clouds flying up animation
              Positioned(
                left: MediaQuery.of(context).size.width * 0.5 - kCloudWidth / 2,
                top: MediaQuery.of(context).size.height *
                    _slideUpAnimation.value,
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: AnimatedCloud(),
                ),
              ),
              // "Welcome back" text animation
              if (_controller.status == AnimationStatus.completed)
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 70),
                  alignment: Alignment.center,
                  child: FadeTransition(
                    opacity: _textAnimation,
                    child: Text(
                      'Welcome ${widget.petName}!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class AnimatedCloud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: kCloudWidth,
      height: kCloudHeight,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child:
                Icon(Icons.cloud, color: Colors.white, size: kSmallCloudSize),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(Icons.cloud, color: Colors.white, size: kBigCloudSize),
          ),
          Align(
            alignment: Alignment.centerRight,
            child:
                Icon(Icons.cloud, color: Colors.white, size: kSmallCloudSize),
          ),
        ],
      ),
    );
  }
}

const double kCloudWidth = 150;
const double kCloudHeight = 100;
const double kSmallCloudSize = 60;
const double kBigCloudSize = 90;
