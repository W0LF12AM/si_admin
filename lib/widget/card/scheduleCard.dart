import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/delete/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/edit/editScheduleDialogue.dart';

class Schedulecard extends StatelessWidget {
  const Schedulecard(
      {super.key,
      required this.semester,
      required this.kelas,
      required this.jam,
      required this.pelakasaan,
      required this.jadwalId});

  final String semester;
  final String kelas;
  final String jam;
  final String pelakasaan;
  final String jadwalId;

  @override
  Widget build(BuildContext context) {
    void deleteJadwal(String jadwalId) {
      print('Menghapus jadwal dengan ID: $jadwalId');
      FirebaseFirestore.instance
          .collection('jadwal')
          .doc(jadwalId)
          .delete()
          .then((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Jadwal berhasil dihapus')));
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error bang : $e")));
      });
    }

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
                  delete: () {
                    deleteJadwal(jadwalId);
                  },
                );
              });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Editscheduledialogue(
                  documentId: jadwalId,
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
                  child:
                      Center(child: Text(semester, style: coursesDescStyle))),
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
