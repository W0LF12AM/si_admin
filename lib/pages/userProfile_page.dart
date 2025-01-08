import 'package:flutter/material.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/widget/card/userProfileCard.dart';
import 'package:si_admin/widget/header/customHeaderWithoutSearch.dart';

class UserprofilePage extends StatelessWidget {
  const UserprofilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Customheaderwithoutsearch(title: 'Users Profile'),
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
                          'Nama',
                          style: coursesStyle,
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Npm', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Email', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Password', style: coursesStyle),
                      )),
                      Expanded(
                          child: Center(
                        child: Text('Kelas', style: coursesStyle),
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
                    Userprofilecard(
                        nama: 'Bayu',
                        npm: '065120067',
                        email: 'bayu@unpak.ac.id',
                        password: 'bayu123',
                        kelas: 'C'),
                    Userprofilecard(
                        nama: 'Bryan',
                        npm: '065120162',
                        email: 'bre@unpak.ac.id',
                        password: 'bre123',
                        kelas: 'F'),
                    Userprofilecard(
                        nama: 'Andhika',
                        npm: '065120025',
                        email: 'andhika@unpak.ac.id',
                        password: 'andhika123',
                        kelas: 'A'),
                  ],
                ),
              ))
            ],
          ))
        ],
      ),
    );
  }
}
