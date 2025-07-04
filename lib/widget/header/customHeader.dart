import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class Customheader extends StatelessWidget {
  const Customheader({super.key, required this.title, required this.pencarian});

  final String title;
  final ValueChanged<String> pencarian;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      width: double.maxFinite,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(color: secondaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.15,
              height: MediaQuery.sizeOf(context).height * 0.05,
              decoration: BoxDecoration(
                  color: bgColor, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  onChanged: pencarian,
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
