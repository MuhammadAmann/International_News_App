import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/signup_screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool toggle = true;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: hieght * .15),
                Center(
                  child: Text(
                    "Login here",
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: hieght * .08),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Email",
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                size: 24,
                                color: Colors.grey.shade600,
                              ),
                              border: OutlineInputBorder()
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: Colors.grey.shade300, width: 2),
                              //     borderRadius: BorderRadius.circular(8)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: Colors.blue.shade300, width: 2),
                              //     borderRadius: BorderRadius.circular(8))
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: hieght * 0.04,
                        ),
                        TextFormField(
                          obscureText: toggle,
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                size: 24,
                                color: Colors.grey.shade600,
                              ),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      toggle = !toggle;
                                    });
                                  },
                                  child: toggle
                                      ? Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.grey.shade600,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                          color: Colors.grey.shade600,
                                        )),
                              border: OutlineInputBorder()
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: Colors.grey.shade300, width: 2),
                              //     borderRadius: BorderRadius.circular(8)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: Colors.blue.shade300, width: 2),
                              //     borderRadius: BorderRadius.circular(8))
                              ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: hieght * 0.06,
                ),
                InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) ;
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      "Login",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: hieght * 0.04,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Text("  or  "),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: Colors.grey.shade300,
                    )),
                  ],
                ),
                SizedBox(
                  height: hieght * 0.04,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Center(
                            child:
                                Image(image: AssetImage("images/google.png"))),
                      ),
                    ),
                    SizedBox(width: width * .04),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Center(
                            child: Image(
                                image: AssetImage("images/facebook.png"))),
                      ),
                    ),
                    SizedBox(width: width * .04),
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200)),
                        child: Center(
                            child:
                                Image(image: AssetImage("images/twitter.png"))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: hieght * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.montserrat(fontSize: 12),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signup_Screen(),
                            ));
                      },
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.montserrat(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}