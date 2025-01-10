import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/dialogue/delete/deleteConfirmationDialogue.dart';
import 'package:si_admin/widget/dialogue/download/downloadDataDialogue.dart';

class Coursescard extends StatefulWidget {
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
  State<Coursescard> createState() => _CoursescardState();
}

class _CoursescardState extends State<Coursescard> {
  Future<List<Map<String, dynamic>>> fetchPresensiData() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('presensi')
        .where('kelas', isEqualTo: widget.kelas)
        .where('pertemuan', isEqualTo: widget.pertemuan)
        .get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    void deleteKelas(String kelasId) {
      Navigator.pop(context);
      print('Menghapus kelas dengan ID: $kelasId');
      FirebaseFirestore.instance
          .collection('kelas')
          .doc(kelasId)
          .delete()
          .then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kelas berhasil dihapus')),
          );
        }
      }).catchError((error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus kelas: $error')),
          );
        }
      });
    }

    void testDeleteKelas() {
      String testKelasId =
          'kelas ${widget.kelasId} dihapus'; // Ganti dengan ID yang valid
      deleteKelas(testKelasId);
    }

    Future<void> downloadDataPresensi(List<Map<String, dynamic>> presensiData,
        String pertemuan, String namaKelas) async {
      var excel = Excel.createExcel();
      Sheet sheet = excel['Sheet1'];

      sheet.appendRow(
          [TextCellValue('Nama'), TextCellValue('Pertemuan $pertemuan')]);

      for (var data in presensiData) {
        String userName = data['userName'];
        int nilaiPresensi = 100;
        sheet.appendRow(
            [TextCellValue(userName), TextCellValue(nilaiPresensi.toString())]);
      }

      var directory = await getApplicationCacheDirectory();

      var rekapDirektori = Directory('${directory.path}/rekap');
      if (!await rekapDirektori.exists()) {
        await rekapDirektori.create(recursive: true);
      }

      String baseFileName = '$namaKelas - Pertemuan $pertemuan';
      String filePath = '${rekapDirektori.path}/$baseFileName.xlsx';

      int copyKe = 1;
      while (await File(filePath).exists()) {
        filePath = '${rekapDirektori.path}/$baseFileName-copy($copyKe).xlsx';
        copyKe++;
      }

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      print('File berhasil diunduh: $filePath');
    }

    void showDownloadDialogueh() async {
      List<Map<String, dynamic>> presensiData = await fetchPresensiData();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Downloaddatadialogue(
              dataPresensi: presensiData,
              download: () async {
                await downloadDataPresensi(
                    presensiData, widget.pertemuan, widget.kelas);
                Navigator.pop(context);
              },
            );
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
                print('kelasi Id yang dipilih : ${widget.kelasId}');
                return DeleteConfirmationDialogue(
                  delete: () {
                    deleteKelas(widget.kelasId);
                  },
                );
              });
        },
        onTap: () {
          showDownloadDialogueh();
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
                      child: Text('pertemuan ${widget.pertemuan}',
                          style: coursesDescStyle))),
              //matprak
              Expanded(
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.kelas,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //jam
              Expanded(
                child: Center(
                  child: Text(
                    widget.jam,
                    style: coursesDescStyle,
                  ),
                ),
              ),
              //lab
              Expanded(
                child: Center(
                  child: Text(
                    widget.pelakasaan,
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
