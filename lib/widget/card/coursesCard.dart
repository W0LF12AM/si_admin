import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/downloadDataDialogue.dart';

class Coursescard extends StatelessWidget {
  const Coursescard(
      {super.key,
      required this.pertemuan,
      required this.kelas,
      required this.jam,
      required this.pelakasaan});

  final String pertemuan;
  final String kelas;
  final String jam;
  final String pelakasaan;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.sizeOf(context).width * 0.04,
          right: MediaQuery.sizeOf(context).width * 0.04,
          bottom: MediaQuery.sizeOf(context).height * 0.01),
      child: GestureDetector(
        onDoubleTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                //delete confirmation
                return DeleteConfirmationDialogue();
              });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Downloaddatadialogue(
                  download: () {},
                );
              });
        },
        child: Container(
          width: double.maxFinite,
          height: MediaQuery.sizeOf(context).height * 0.07,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //smester
              Expanded(
                  child: Center(
                      child: Text('pertemuan $pertemuan',
                          style: coursesDescStyle))),
              //matprak
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    kelas,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //jam
              Expanded(
                child: Center(
                  child: Text(
                    jam,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //lab
              Expanded(
                child: Center(
                  child: Text(
                    pelakasaan,
                    style: coursesDescStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
