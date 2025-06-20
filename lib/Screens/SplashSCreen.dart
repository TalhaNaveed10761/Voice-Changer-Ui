import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_29/Screens/DotSCreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {

  @override
   void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DotScreen()),
      );
    });
  }
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child: SvgPicture.asset("assets/Icon.svg")),
    );
  }
}