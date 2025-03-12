import 'package:flutter/material.dart';
import 'package:liquid_wave_animate_button/liquid_wave_animate_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LiquidWaveAnimateButton(
                  buttonName: 'Liquid Wave',
                  width: 300,
                  height: 60,
                  fillLevel: 0.2,
                  liquidColor: Colors.pink,
                  ariseAnimation: true, // Water fill & wave animation
                  ariseDuration: const Duration(seconds: 2),
                  borderColor: Colors.white,
                  borderWidth: 2.0,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    print("button pressed!");
                  },
                ),
                const SizedBox(height: 20),
                LiquidWaveAnimateButton(
                  buttonName: 'Liquid Wave',
                  width: 300,
                  height: 60,
                  fillLevel: 0.6,
                  liquidColor: Colors.red,
                  ariseAnimation: true,
                  ariseDuration: const Duration(seconds: 2),
                  borderColor: Colors.white,
                  borderWidth: 2.0,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    print("button pressed!");
                  },
                ),
                const SizedBox(height: 20),
                LiquidWaveAnimateButton(
                  buttonName: 'Liquid Wave',
                  width: 300,
                  height: 60,
                  fillLevel: 0.8,
                  liquidColor: Colors.green,
                  ariseAnimation: true,
                  ariseDuration: const Duration(seconds: 2),
                  borderColor: Colors.white,
                  borderWidth: 2.0,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    print("button pressed!");
                  },
                ),
                const SizedBox(height: 20),
                LiquidWaveAnimateButton(
                  buttonName: 'Liquid Wave',
                  width: 300,
                  height: 60,
                  fillLevel: 1.1,
                  liquidColor: Colors.lightBlue,
                  ariseAnimation: true,
                  ariseDuration: const Duration(seconds: 2),
                  borderColor: Colors.white,
                  borderWidth: 2.0,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    print("button pressed!");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
