import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/editScheduleDialogue.dart';

class Userprofilecard extends StatelessWidget {
  const Userprofilecard(
      {super.key,
      required this.nama,
      required this.npm,
      required this.email,
      required this.password,
      required this.kelas});

  final String nama;
  final String npm;
  final String email;
  final String password;
  final String kelas;

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
                return DeleteConfirmationDialogue(
                  delete: () {},
                );
              });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Editscheduledialogue();
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
                  child: Center(child: Text(nama, style: coursesDescStyle))),
              //matprak
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    npm,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //email
              Expanded(
                child: Center(
                  child: Text(
                    email,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //lab
              Expanded(
                child: Center(
                  child: Text(
                    password,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    kelas,
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
