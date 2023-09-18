import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/login_screen.dart';
import 'package:international_news_app/View/signup_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    const colorizeColors = [
      Colors.white,
      Colors.white30,
    ];
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.newspaper,
                color: Colors.white,
                size: 170,
              ),
            ),
            Text(
              "WorldWide News",
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: hieght * .25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login_Screen()));
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Signup_Screen(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: GoogleFonts.montserrat(color: Colors.blue),
                    )),
                  ),
                )
              ],
            ),
            SizedBox(height: hieght * .06),
            Center(
              child: AnimatedTextKit(
                
                animatedTexts: [
                        ColorizeAnimatedText(  
                    'Continue as a guest',
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),

            // Text(
            //   "Continue as a guest ",
            //   style: GoogleFonts.montserrat(
            //       color: Colors.white,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w400),
            // ),
          ],
        ),
      ),
    );
  }
}
