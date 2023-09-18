import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/home.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/splash_pic.png',
              fit: BoxFit.cover,
              // width: width * .9,
              height: hieght * .5,
            ),
            SizedBox(height: hieght * .04),
            Text(
              "TOP HEADLINES",
              style: GoogleFonts.anton(
                  letterSpacing: .6, color: Colors.grey.shade700, fontSize: 20),
            ),
            SizedBox(height: hieght * .04),
            SpinKitChasingDots(
              size: 40,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

}
