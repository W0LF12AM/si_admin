import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:si_admin/const/default.dart';
import 'package:si_admin/pages/course_page.dart';
import 'package:si_admin/pages/locationSetting_page.dart';
import 'package:si_admin/pages/schedule_page.dart';
import 'package:si_admin/pages/userProfile_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.05, // Lebar sidebar
            color: mainColor,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _onItemTapped(0);
                    },
                    child: SvgPicture.asset(
                      'assets/admin icon.svg',
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ),
                  // Menu Items
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 0
                                  ? secondaryColor
                                  : mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/courses icon.svg',
                            width: MediaQuery.of(context).size.width * 0.04,
                            height: MediaQuery.of(context).size.height * 0.04,
                            color: _selectedIndex == 0
                                ? mainColor
                                : secondaryColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(0);
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 1
                                  ? secondaryColor
                                  : mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/schedule icon.svg',
                            width: MediaQuery.of(context).size.width * 0.04,
                            height: MediaQuery.of(context).size.height * 0.04,
                            color: _selectedIndex == 1
                                ? mainColor
                                : secondaryColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(1);
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 2 || _selectedIndex == 4
                                  ? secondaryColor
                                  : mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/location setting icon.svg',
                            width: MediaQuery.of(context).size.width * 0.04,
                            height: MediaQuery.of(context).size.height * 0.04,
                            color: _selectedIndex == 2 || _selectedIndex == 4
                                ? mainColor
                                : secondaryColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(2);
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: _selectedIndex == 3
                                  ? secondaryColor
                                  : mainColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: SvgPicture.asset(
                            'assets/user profile icon.svg',
                            width: MediaQuery.of(context).size.width * 0.04,
                            height: MediaQuery.of(context).size.height * 0.04,
                            color: _selectedIndex == 3
                                ? mainColor
                                : secondaryColor,
                          ),
                        ),
                        onTap: () {
                          _onItemTapped(3);
                        },
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () {
                      exit(0);
                    },
                    child: SvgPicture.asset(
                      'assets/exit icon.svg',
                      color: secondaryColor,
                      width: MediaQuery.of(context).size.width * 0.04,
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //body
          Expanded(
              child: IndexedStack(
            index: _selectedIndex,
            children: [
              const CoursePage(),
              const SchedulePage(),
              const LocationsettingPage(),
              const UserprofilePage()
            ],
          ))
        ],
      ),
    );
  }
}
