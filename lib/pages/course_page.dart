import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/cardInformationHeader.dart';
import 'package:si_admin/widget/dialogue/addCoursesDialogue.dart';
import 'package:si_admin/widget/header/customHeader.dart';
import 'package:si_admin/widget/card/coursesCard.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheader(
                title: 'Courses',
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                child: Row(
                  children: [
                    Cardinformationheader(
                      cardIcon: Icons.person,
                      informasi: '20',
                      judulCard: 'Users',
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Cardinformationheader(
                      cardIcon: Icons.book_outlined,
                      informasi: '4',
                      judulCard: 'Courses',
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Cardinformationheader(
                      cardIcon: Icons.notifications,
                      informasi: '10',
                      judulCard: 'Notifications',
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    Cardinformationheader(
                      cardIcon: Icons.location_on_outlined,
                      informasi: '4',
                      judulCard: 'Location',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.04),
                child: Container(
                  width: double.maxFinite,
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //smester
                      Expanded(
                          child: Center(
                              child: Text('Pertemuan', style: coursesStyle))),
                      //matprak
                      Expanded(
                        child: Center(
                          child: Text(
                            'Mata Praktikum',
                            style: coursesStyle,
                          ),
                        ),
                      ),
                      //jam
                      Expanded(
                        child: Center(
                          child: Text(
                            'Jam',
                            style: coursesStyle,
                          ),
                        ),
                      ),
                      //lab
                      Expanded(
                        child: Center(
                          child: Text(
                            'Pelaksanaan',
                            style: coursesStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Coursescard(
                        pertemuan: '4',
                        kelas: 'Statistika Dasar C',
                        jam: '14.30 - 16.00',
                        pelakasaan: 'Lab MM'),
                    Coursescard(
                        pertemuan: '4',
                        kelas: 'Statistika Dasar C',
                        jam: '14.30 - 16.00',
                        pelakasaan: 'Lab SC'),
                    Coursescard(
                        pertemuan: '4',
                        kelas: 'Mobile Programming Ekstensi',
                        jam: '21.30 - 23.00',
                        pelakasaan: 'online'),
                    Coursescard(
                        pertemuan: '4',
                        kelas: 'Pemrograman Beroreantasi Objek C',
                        jam: '14.30 - 16.00',
                        pelakasaan: 'Lab SC'),
                  ],
                ),
              ))
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Addcoursesdialogue();
              });
        },
        child: Icon(
          Icons.add,
          color: secondaryColor,
        ),
        backgroundColor: mainColor,
      ),
    );
  }
}
