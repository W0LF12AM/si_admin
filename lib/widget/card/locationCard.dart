import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/delete/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/edit/editLokasiDialogue.dart';

class Locationcard extends StatefulWidget {
  const Locationcard(
      {super.key,
      required this.tempat,
      required this.longitude,
      required this.latitude,
      required this.radius,
      required this.lokasiId});

  final String tempat;
  final String longitude;
  final String latitude;
  final String radius;
  final String lokasiId;

  @override
  State<Locationcard> createState() => _LocationcardState();
}

class _LocationcardState extends State<Locationcard> {
  void deleteLokasi(BuildContext context, String lokasiId) {
    Navigator.pop(context);
    print('berhasil menghapus lokasi : $lokasiId');
    FirebaseFirestore.instance
        .collection('lokasi')
        .doc(lokasiId)
        .delete()
        .then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Lokasi berhasil dihapus')));
      }
    }).catchError((e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error bang : $e")));
      }
    });
  }

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
                  delete: () {
                    deleteLokasi(context, widget.lokasiId);
                  },
                );
              });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Editlokasidialogue(
                  documentId: widget.lokasiId,
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
                      child: Text(widget.tempat, style: coursesDescStyle))),
              //matprak
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.longitude,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //latitude
              Expanded(
                child: Center(
                  child: Text(
                    widget.latitude,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //lab
              Expanded(
                child: Center(
                  child: Text(
                    widget.radius,
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
