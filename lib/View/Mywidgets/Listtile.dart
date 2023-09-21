import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyList extends StatelessWidget {
  String title;
  Icon icondata;
  MyList({super.key, required this.title, required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: icondata,
        ),
        SizedBox(width: 2),
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
