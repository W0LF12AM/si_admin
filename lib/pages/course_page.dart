import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/cardInformationHeader.dart';
import 'package:si_admin/widget/dialogue/add/addCoursesDialogue.dart';
import 'package:si_admin/widget/header/customHeader.dart';
import 'package:si_admin/widget/card/coursesCard.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String queryPencarian = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> kelas =
        FirebaseFirestore.instance.collection('kelas').snapshots();
    final Stream<QuerySnapshot> lokasi =
        FirebaseFirestore.instance.collection('lokasi').snapshots();
    final Stream<QuerySnapshot> jadwal =
        FirebaseFirestore.instance.collection('jadwal').snapshots();

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheader(
                pencarian: (query) {
                  setState(() {
                    queryPencarian = query;
                  });
                },
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
                    StreamBuilder<QuerySnapshot>(
                        stream: kelas,
                        builder: (context, snapshot) {
                          print(
                              'Connection State: ${snapshot.connectionState}');
                          print('Has Error: ${snapshot.hasError}');
                          print('Has Data: ${snapshot.hasData}');

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Cardinformationheader(
                              cardIcon: Icons.book_outlined,
                              informasi: '0',
                              judulCard: 'Courses',
                            );
                          }
                          if (snapshot.hasError) {
                            return Cardinformationheader(
                              cardIcon: Icons.book_outlined,
                              informasi: 'Error',
                              judulCard: 'Courses',
                            );
                          }
                          final kelasCount = snapshot.data!.docs.length;
                          return Cardinformationheader(
                            cardIcon: Icons.book_outlined,
                            informasi: kelasCount.toString(),
                            judulCard: 'Courses',
                          );
                        }),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: jadwal,
                        builder: (context, snapshot) {
                          print(
                              'Connection State: ${snapshot.connectionState}');
                          print('Has Error: ${snapshot.hasError}');
                          print('Has Data: ${snapshot.hasData}');

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Cardinformationheader(
                              cardIcon: Icons.calendar_month,
                              informasi: '0',
                              judulCard: 'Schedules',
                            );
                          }
                          if (snapshot.hasError) {
                            return Cardinformationheader(
                              cardIcon: Icons.calendar_month,
                              informasi: 'Error',
                              judulCard: 'Schedules',
                            );
                          }
                          final jadwalCount = snapshot.data!.docs.length;

                          return Cardinformationheader(
                            cardIcon: Icons.calendar_month,
                            informasi: jadwalCount.toString(),
                            judulCard: 'Schedules',
                          );
                        }),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: lokasi,
                        builder: (context, snapshot) {
                          print(
                              'Connection State: ${snapshot.connectionState}');
                          print('Has Error: ${snapshot.hasError}');
                          print('Has Data: ${snapshot.hasData}');

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Cardinformationheader(
                              cardIcon: Icons.book_outlined,
                              informasi: '0',
                              judulCard: 'Locations',
                            );
                          }
                          if (snapshot.hasError) {
                            return Cardinformationheader(
                              cardIcon: Icons.book_outlined,
                              informasi: 'Error',
                              judulCard: 'Locations',
                            );
                          }
                          final lokasiDocs = snapshot.data!.docs;
                          final lokasiCoont = snapshot.data!.docs.length;

                          List<String> lokasiDetails = lokasiDocs.map((doc) {
                            return 'Tempat: ${doc['tempat']}, Lat: ${doc['latitude']}, Long: ${doc['longitude']}, Rad: ${doc['radius']}';
                          }).toList();

                          for (var detail in lokasiDetails) {
                            print(detail);
                          }

                          return Cardinformationheader(
                            cardIcon: Icons.book_outlined,
                            informasi: lokasiCoont.toString(),
                            judulCard: 'Locations',
                          );
                        }),
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
                    StreamBuilder<QuerySnapshot>(
                        stream: kelas,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error : ${snapshot.error}'),
                            );
                          }

                          final kelasDocs = snapshot.data!.docs;

                          final filteredKelas = kelasDocs.where((kelasDoc) {
                            final namaKelas =
                                kelasDoc['kelas'].toString().toLowerCase();
                            return namaKelas
                                .contains(queryPencarian.toLowerCase());
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredKelas.length,
                            itemBuilder: (context, index) {
                              final kelasDoc = filteredKelas[index];
                              return Coursescard(
                                pertemuan: kelasDoc['pertemuan'],
                                kelas: kelasDoc['kelas'],
                                jam: kelasDoc['jam'],
                                pelakasaan: kelasDoc['tempat'],
                                kelasId: kelasDoc.id,
                              );
                            },
                          );
                        })
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
