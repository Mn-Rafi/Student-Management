import 'package:flutter/material.dart';
import 'screenone.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigatetoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          width: 200, 
          image: AssetImage('images/splashimage.png',),
        ),
      ),
    );
  }

  _navigatetoHome() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const ScreenOne()));
  }
}
