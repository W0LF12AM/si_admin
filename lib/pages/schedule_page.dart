import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/scheduleCard.dart';
import 'package:si_admin/widget/dialogue/add/addScheduleDialogue.dart';

import 'package:si_admin/widget/header/customHeaderWithoutSearch.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheaderwithoutsearch(title: 'Schedule'),
              SizedBox(
                height: 30,
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
                    children: [
                      Expanded(
                          child: Center(
                        child: Text(
                          'Semester',
                          style: coursesStyle,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Kelas', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Jam', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Tempat', style: coursesStyle),
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('jadwal')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error bang : ${snapshot.error}'),
                          );
                        }

                        final jadwals = snapshot.data!.docs;

                        if (jadwals.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak ada jadwal',
                              style: coursesStyle,
                            ),
                          );
                        }

                        return ListView(
                          children: jadwals.map((jadwalDoc) {
                            return Schedulecard(
                                semester: jadwalDoc['semester'],
                                kelas: jadwalDoc['kelas'],
                                jam: jadwalDoc['jam'],
                                pelakasaan: jadwalDoc['tempat'],
                                jadwalId: jadwalDoc.id);
                          }).toList(),
                        );
                      }))
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Addscheduledialogue();
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
