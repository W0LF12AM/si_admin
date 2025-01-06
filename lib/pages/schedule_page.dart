import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/scheduleCard.dart';
import 'package:si_admin/widget/dialogue/addScheduleDialogue.dart';
import 'package:si_admin/widget/header/customHeader.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheader(title: 'Schedule'),
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
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Schedulecard(
                        semester: '6',
                        kelas: 'Mobile Programming Gab C',
                        jam: '14.30 - 16.00',
                        pelakasaan: 'Lab SC'),
                    Schedulecard(
                        semester: '4',
                        kelas: 'Statistika Dasar C',
                        jam: '13.00 - 14.30',
                        pelakasaan: 'Online'),
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
