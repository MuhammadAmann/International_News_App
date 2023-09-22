import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/Mywidgets/Listtile.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_ProfileState();
}

class _User_ProfileState extends State<User_Profile> {
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: hieght * .03,
                ),
                Center(
                  child: Text("Profile Setting",
                      style: GoogleFonts.montserrat(
                          color: Colors.blue.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),

                SizedBox(
                  height: hieght * .05,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue.shade800,
                    child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80')),
                  ),
                ),
                SizedBox(
                  height: hieght * .03,
                ),
                Center(
                  child: Text(
                    "User Admin",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: hieght * .01,
                ),
                const Center(child: Text("Useradmin@gmail.com")),

                //List Create here

                SizedBox(
                  height: hieght * .05,
                ),
                Text(
                  "Profile",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Personal Data",
                    icondata: Icon(Icons.person_3_outlined,
                        color: Colors.black.withOpacity(.6))),
                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Language",
                    icondata: Icon(Icons.language_outlined,
                        color: Colors.black.withOpacity(.6))),
                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Notification",
                    icondata: Icon(Icons.notifications_active_outlined,
                        color: Colors.black.withOpacity(.6))),

                SizedBox(
                  height: hieght * .05,
                ),
                Text(
                  "Security",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Password",
                    icondata: Icon(Icons.lock_outline_rounded,
                        color: Colors.black.withOpacity(.6))),
                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Privacy Policy",
                    icondata: Icon(Icons.privacy_tip_outlined,
                        color: Colors.black.withOpacity(.6))),

                SizedBox(
                  height: hieght * .04,
                ),
                MyList(
                    title: "Log out",
                    icondata: Icon(Icons.logout_outlined,
                        color: Colors.black.withOpacity(.6))),
                SizedBox(
                  height: hieght * .06,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
