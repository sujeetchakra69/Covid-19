import 'dart:async';

import 'package:covid19/components/World_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>const WorldState())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: SizedBox(
                  height: MediaQuery.of(context).size.width*.4,
                  width: MediaQuery.sizeOf(context).width*.4,
          
                  child:  Center(
                    child: Image.asset('images/Virus.png'),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                },
              ),
            const SizedBox(height: 20,),
            const Text('Corona -19 Cases',style: TextStyle(fontSize: 20.0),),
          
          
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
