import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/editScheduleDialogue.dart';

class Locationcard extends StatelessWidget {
  const Locationcard(
      {super.key,
      required this.tempat,
      required this.longitude,
      required this.latitude,
      required this.radius});

  final String tempat;
  final String longitude;
  final String latitude;
  final String radius;

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
                  child: Center(child: Text(tempat, style: coursesDescStyle))),
              //matprak
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    longitude,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //latitude
              Expanded(
                child: Center(
                  child: Text(
                    latitude,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //lab
              Expanded(
                child: Center(
                  child: Text(
                    radius,
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
