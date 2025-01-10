import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:si_admin/const/default.dart';

class Downloaddatadialogue extends StatelessWidget {
  const Downloaddatadialogue(
      {super.key, required this.download, required this.dataPresensi});
  final List<Map<String, dynamic>> dataPresensi;
  final VoidCallback download;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.22,
        height: MediaQuery.sizeOf(context).height * 0.45,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unduh Data',
              style: GoogleFonts.poppins(
                  fontSize: MediaQuery.sizeOf(context).width * 0.015,
                  color: mainColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.005,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.sizeOf(context).width * 0.15),
              child: const Divider(
                color: mainColor,
                thickness: 4,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: dataPresensi.length,
                    itemBuilder: (context, index) {
                      final data = dataPresensi[index];
                      String formatedTime = DateFormat('kk:mm\ndd / MM / yyyy')
                          .format((data['jam'] as Timestamp).toDate());
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  data['userName'],
                                  style: coursesStyle,
                                )),
                                Expanded(
                                    child: Text(
                                  textAlign: TextAlign.end,
                                  formatedTime,
                                  style: coursesDownloadInfoStyle,
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            Text(
              'Unduh data kelas ini ?',
              style: GoogleFonts.poppins(
                  fontSize: MediaQuery.sizeOf(context).width * 0.01,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            GestureDetector(
              onTap: download,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.07,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Download',
                        style: GoogleFonts.poppins(
                            color: secondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
