import 'package:cloud_firestore/cloud_firestore.dart';
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
      required this.pelakasaan,
      required this.kelasId});

  final String pertemuan;
  final String kelas;
  final String jam;
  final String pelakasaan;
  final String kelasId;

  @override
  Widget build(BuildContext context) {
    void deleteKelas(String kelasId) {
      print('Menghapus kelas dengan ID: $kelasId');
      FirebaseFirestore.instance
          .collection('kelas')
          .doc(kelasId)
          .delete()
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kelas berhasil dihapus')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus kelas: $error')),
        );
      });
    }

    void testDeleteKelas() {
      String testKelasId =
          'kelas $kelasId dihapus'; // Ganti dengan ID yang valid
      deleteKelas(testKelasId);
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
                print('kelasi Id yang dipilih : $kelasId');
                return DeleteConfirmationDialogue(
                  delete: () {
                    deleteKelas(kelasId);
                  },
                );
              });
        },
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Downloaddatadialogue(
                  download: () {
                    
                  },
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
