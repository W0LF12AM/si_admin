import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:si_admin/const/default.dart';

class Cardinformationheader extends StatelessWidget {
  Cardinformationheader(
      {super.key,
      required this.cardIcon,
      required this.informasi,
      required this.judulCard});

  final IconData cardIcon;
  final String informasi;
  final String judulCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.2,
      height: MediaQuery.sizeOf(context).height * 0.15,
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.003,
        ),
        child: Row(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.07,
              height: MediaQuery.sizeOf(context).height * 0.07,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: mainColor),
              child: Icon(
                cardIcon,
                size: MediaQuery.sizeOf(context).height * 0.05,
                color: secondaryColor,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).height * 0.001,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.sizeOf(context).height * 0.025,
              ),
              child: VerticalDivider(
                color: mainColor,
                thickness: 3,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).height * 0.01,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  informasi,
                  style: GoogleFonts.roboto(
                      fontSize: MediaQuery.sizeOf(context).height * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  judulCard,
                  style: GoogleFonts.roboto(
                      fontSize: MediaQuery.sizeOf(context).height * 0.02,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
